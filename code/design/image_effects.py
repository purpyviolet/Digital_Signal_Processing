import cv2
import numpy as np

def apply_mosaic(image, block_size=10):
    """
    Apply a mosaic (pixelation) effect to the image.
    :param image: Input image
    :param block_size: Size of each block
    :return: Image with mosaic effect
    """
    for i in range(0, image.shape[0], block_size):
        for j in range(0, image.shape[1], block_size):
            image[i:i+block_size, j:j+block_size] = np.median(image[i:i+block_size, j:j+block_size], axis=(0, 1)).astype(np.uint8)
    return image

def apply_vignette(image, strength=0.5):
    """
    Apply a vignette effect to the image.
    :param image: Input image
    :param strength: Strength of the vignette effect
    :return: Image with vignette effect
    """
    rows, cols = image.shape[:2]
    kernel_x = cv2.getGaussianKernel(cols, cols * strength)
    kernel_y = cv2.getGaussianKernel(rows, rows * strength)
    kernel = kernel_y * kernel_x.T
    mask = 255 * kernel / np.linalg.norm(kernel)
    mask = mask.astype(np.uint8)
    vignette = np.dstack([mask] * 3)
    return cv2.addWeighted(image, 1, vignette, -1, 0)

def apply_thermal_effect(image):
    """
    Simulate a thermal camera effect.
    :param image: Input image
    :return: Image with thermal effect
    """
    gray = cv2.cvtColor(image, cv2.COLOR_BGR2GRAY)
    heatmap = cv2.applyColorMap(gray, cv2.COLORMAP_JET)
    return heatmap

def apply_sketch_effect(image, sigma_s=60, sigma_r=0.07):
    """
    Convert an image to a sketch-like effect using edge-preserving filtering.
    :param image: Input image
    :param sigma_s: Range between 0 and 200.
    :param sigma_r: Range between 0 and 1.
    :return: Sketch-like effect image
    """
    return cv2.stylization(image, sigma_s=sigma_s, sigma_r=sigma_r)

def apply_cartoon_effect(image):
    """
    Apply a cartoon effect to an image.
    :param image: Input image
    :return: Cartoon-styled image
    """
    # Use bilateral filter for edge-aware smoothing.
    smooth = cv2.bilateralFilter(image, d=9, sigmaColor=75, sigmaSpace=75)
    # Convert to grayscale and apply median blur
    gray = cv2.cvtColor(smooth, cv2.COLOR_BGR2GRAY)
    gray = cv2.medianBlur(gray, 7)
    # Detect edges and enhance them
    edges = cv2.adaptiveThreshold(gray, 255, cv2.ADAPTIVE_THRESH_MEAN_C, cv2.THRESH_BINARY, blockSize=9, C=2)
    # Combine the edges and the smoothed image
    cartoon = cv2.bitwise_and(smooth, smooth, mask=edges)
    return cartoon

