import cv2
import numpy as np


def resize_image(image, scale_factor):
    """
    Resize an image by a given scale factor.
    :param image: Input image.
    :param scale_factor: Scale factor for resizing, e.g., 2 for doubling the size, 0.5 for halving.
    :return: Resized image.
    """
    # Calculate new dimensions
    new_width = round(image.shape[1] * scale_factor)
    new_height = round(image.shape[0] * scale_factor)
    new_dimensions = (new_width, new_height)

    # Resize using LINEAR interpolation
    resized_image = cv2.resize(image, new_dimensions, interpolation=cv2.INTER_LINEAR)

    return resized_image


def rotate_image(image, angle, scale=1.0):
    """
    Rotate an image by a given angle.
    :param image: Input image.
    :param angle: Angle in degrees to rotate the image. Positive values mean counter-clockwise rotation.
    :param scale: Scale factor during rotation. Default is 1.0.
    :return: Rotated image.
    """
    center = (image.shape[1] // 2, image.shape[0] // 2)
    rotation_matrix = cv2.getRotationMatrix2D(center, angle, scale)
    new_dimensions = (image.shape[1], image.shape[0])
    rotated_image = cv2.warpAffine(image, rotation_matrix, new_dimensions)
    return rotated_image


