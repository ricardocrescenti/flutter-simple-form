import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:simple_form/simple_form.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class SimpleImageField extends SimpleFormField {
	final Size size;
	final Widget emptyWidget;
	final bool cropImage;
	final double aspectRatioX;
	final double aspectRatioY;
	final Future<String> Function(String value) onGetUrl;
	final dynamic Function(dynamic value) onGetImage;

	SimpleImageField({
		Key key,
		String title,
		@required String fieldName,
		bool enabled = true,
		this.size = const Size(150, 150),
		this.emptyWidget,
		this.cropImage = true,
		this.aspectRatioX = 1.0, 
		this.aspectRatioY = 1.0,
		List<SimpleValidator> validators,
		Function(dynamic newValue) onChange,
		this.onGetUrl,
		this.onGetImage
	}) : super(
		key: key, 
		fieldName: fieldName, 
		title: title,
		enabled: enabled,
		validators: validators,
		onChange: onChange,
		canSetState: true);

  	@override
  	Widget build(BuildContext context, SimpleFormFieldState field) {
		return Container(
			margin: EdgeInsets.symmetric(vertical: 10),
			child: _createBody(context, field),
		);
  	}

	Widget _createBody(BuildContext context, SimpleFormFieldState field) {
		return Column(
			crossAxisAlignment: CrossAxisAlignment.start,
			mainAxisSize: MainAxisSize.min,
			children: [
				(field.widget.title != null 
					? Padding(
						padding: EdgeInsets.only(bottom: 5),
						child: Text(field.widget.title, style: Theme.of(context).textTheme.caption)
					)
					: null
				),
				Row(
					crossAxisAlignment: CrossAxisAlignment.start,
					mainAxisSize: MainAxisSize.max,
					children: [
						Container(
							decoration: BoxDecoration(
								border: Border(
									left: BorderSide(color: Theme.of(context).dividerColor),
									top: BorderSide(color: Theme.of(context).dividerColor),
									right: BorderSide(color: Theme.of(context).dividerColor),
									bottom: BorderSide(color: Theme.of(context).dividerColor)
								)
							),
							height: size.height,
							width: size.width,
							child: _createImageWidget(context, field)
						),
						_createOperationsButtons(context, field)
					]
				)
			].where((element) => element != null).toList(),
		);
	}

	_createImageWidget(BuildContext context, SimpleFormFieldState field) {
		if (field.value == null || (field.value is String && field.value.isEmpty)) {
			return Center(
				child: emptyWidget
			);
		}

		Future<String> url = Future.value(field.value.toString());
		if (onGetUrl != null) {
			url = onGetUrl(field.value.toString());
		}

		return FutureBuilder<String>(
			future: url,
			builder: (context, snapshot) {

				if (snapshot.connectionState != ConnectionState.done) {
					return Center(
						child: CircularProgressIndicator()
					);
				}

				if (snapshot.hasError) {
					return Center(
						child: Icon(Icons.error)
					);
				}

				if (!snapshot.hasData == null || snapshot.data.isEmpty) {
					return Center(
						child: emptyWidget
					);
				}

				if (snapshot.data.startsWith('/')) {
					return Image.file(File(snapshot.data));
				}

				return CachedNetworkImage(
					imageUrl: snapshot.data, 
					width: double.infinity, 
					height: double.infinity, 
					fit: BoxFit.cover);

			}
		);
	}

	_createOperationsButtons(BuildContext context, SimpleFormFieldState field) {
		return Column(
			mainAxisSize: MainAxisSize.min,
			children: [
				_createSelectGalleryImageButton(context, field),
				_createSelectCameraPhotoButton(context, field),
				_createClearImageButton(context, field)
			]
		);
	}

	_createSelectGalleryImageButton(BuildContext context, SimpleFormFieldState field) {
		return IconButton(
			icon: Icon(Icons.photo_album), 
			onPressed: (enabled ? () => _selectImageFromGallery(field) : null)
		);
	}

	_createSelectCameraPhotoButton(BuildContext context, SimpleFormFieldState field) {
		return IconButton(
			icon: Icon(Icons.photo_camera), 
			onPressed: (enabled ? () => _selectImageFromCamera(field) : null)
		);
	}

	_createClearImageButton(BuildContext context, SimpleFormFieldState field) {
		return IconButton(
			icon: Icon(Icons.clear), 
			onPressed: (enabled ? () => _clearImage(field) : null)
		);
	}

	_selectImageFromGallery(SimpleFormFieldState field) {
		_selectImage(ImageSource.gallery, field);
	}

	_selectImageFromCamera(SimpleFormFieldState field) {
		_selectImage(ImageSource.camera, field);
	}

	_selectImage(ImageSource imageSource, SimpleFormFieldState field) async {
		File file = await selectImage(imageSource, cropImage: this.cropImage, aspectRatioX: aspectRatioX, aspectRatioY: aspectRatioY);
		if (file == null) {
			return;
		}

		if (onGetImage != null) {
			await onGetImage(file.path);
		}

		field.setValue(file.path); 
	}

	static Future<File> selectImage(ImageSource imageSource, { bool cropImage = true, double aspectRatioX = 1.0, double aspectRatioY = 1.0 }) async {
		PickedFile originalFile = await ImagePicker().getImage(source: imageSource);
		if (originalFile == null) {
			return null;
		}
		File file = File.fromUri(Uri(path: originalFile.path));

		if (cropImage) {
			file = await ImageCropper.cropImage(
				sourcePath: file.path,
				aspectRatio: CropAspectRatio(
					ratioX: aspectRatioX, 
					ratioY: aspectRatioY
				),
			);

			if (file == null) {
				return null;
			}
		}

		return file;
	}

	_clearImage(SimpleFormFieldState field) {
		field.setValue(null);
	}
}