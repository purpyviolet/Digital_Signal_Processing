import cv2
import numpy as np

# 例如，这是一个使用卷积核1的函数
def kernel_lowpass_1(image):
    kernel = np.array([[1, 1, 1],
                       [1, 1, 1],
                       [1, 1, 1]]) / 9
    return cv2.filter2D(image, -1, kernel)

def kernel_lowpass_2(image):
    kernel = np.array([[1, 1, 1],
                       [1, 2, 1],
                       [1, 1, 1]]) / 10
    return cv2.filter2D(image, -1, kernel)

def kernel_lowpass_3(image):
    kernel = np.array([[1, 2, 1],
                       [2, 4, 2],
                       [1, 2, 1]]) / 16
    return cv2.filter2D(image, -1, kernel)

def kernel_highpass_1(image):
    kernel = np.array([[0, -1, 0],
                       [-1, 5, -1],
                       [0, -1, 0]])
    return cv2.filter2D(image, -1, kernel)

def kernel_highpass_2(image):
    kernel = np.array([[-1, -1, -1],
                       [-1, 9, -1],
                       [-1, -1, -1]])
    return cv2.filter2D(image, -1, kernel)

def kernel_highpass_3(image):
    kernel = np.array([[1, -2, 1],
                       [-2, 5, -2],
                       [1, -2, 1]])
    return cv2.filter2D(image, -1, kernel)

def kernel_move_detection_horizontal(image):
    kernel = np.array([[0, 0, 0],
                       [-1, 1, 0],
                       [0, 0, 0]])
    return cv2.filter2D(image, -1, kernel)

def kernel_move_detection_vertical(image):
    kernel = np.array([[0, -1, 0],
                       [0, 1, 0],
                       [0, 0, 0]])
    return cv2.filter2D(image, -1, kernel)

def kernel_move_detection_diagonal(image):
    kernel = np.array([[-1, 0, 0],
                       [0, 1, 0],
                       [0, 0, 0]])
    return cv2.filter2D(image, -1, kernel)

def kernel_horizontal_match_detection(image):
    kernel = np.array([[-1, -1, -1, -1, -1],
                       [0, 0, 0, 0, 0],
                       [1, 1, 1, 1, 1]])
    return cv2.filter2D(image, -1, kernel)

def kernel_vertical_match_detection(image):
    kernel = np.array([[-1, 0, 1],
                       [-1, 0, 1],
                       [-1, 0, 1]])
    return cv2.filter2D(image, -1, kernel)


def kernel_edge_1(image):
    kernel = np.array([[-1, 0, -1],
                       [0, 4, 0],
                       [-1, 0, -1]])
    return cv2.filter2D(image, -1, kernel)

def kernel_edge_2(image):
    kernel = np.array([[-1, -1, -1],
                       [-1, 8, -1],
                       [-1, -1, -1]])
    return cv2.filter2D(image, -1, kernel)

def kernel_edge_3(image):
    kernel = np.array([[-1, -1, -1],
                       [-1, 9, -1],
                       [-1, -1, -1]])
    return cv2.filter2D(image, -1, kernel)

def kernel_edge_4(image):
    kernel = np.array([[1, -2, 1],
                       [-2, 4, -2],
                       [1, -2, 1]])
    return cv2.filter2D(image, -1, kernel)

def kernel_gradient_1(image):
    kernel = np.array([[1, 1, 1],
                       [1, -2, 1],
                       [-1, -1, -1]])
    return cv2.filter2D(image, -1, kernel)

def kernel_gradient_2(image):
    kernel = np.array([[1, 1, 1],
                       [-1, -2, 1],
                       [-1, -1, 1]])
    return cv2.filter2D(image, -1, kernel)

def kernel_gradient_3(image):
    kernel = np.array([[-1, 1, 1],
                       [-1, -2, 1],
                       [-1, 1, 1]])
    return cv2.filter2D(image, -1, kernel)

def kernel_gradient_4(image):
    kernel = np.array([[-1, -1, 1],
                       [-1, -2, 1],
                       [1, 1, 1]])
    return cv2.filter2D(image, -1, kernel)

def kernel_gradient_5(image):
    kernel = np.array([[-1, -1, -1],
                       [1, -2, 1],
                       [1, 1, 1]])
    return cv2.filter2D(image, -1, kernel)

def kernel_gradient_6(image):
    kernel = np.array([[1, -1, -1],
                       [1, -2, -1],
                       [1, 1, 1]])
    return cv2.filter2D(image, -1, kernel)

def kernel_gradient_7(image):
    kernel = np.array([[1, 1, -1],
                       [1, -2, -1],
                       [1, 1, -1]])
    return cv2.filter2D(image, -1, kernel)

def kernel_gradient_8(image):
    kernel = np.array([[1, 1, 1],
                       [1, -2, -1],
                       [1, -1, -1]])
    return cv2.filter2D(image, -1, kernel)

