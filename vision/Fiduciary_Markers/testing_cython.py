import timeit

cy = timeit.timeit('''example_python.test(5)''',setup='import example_python',number=100)
#py = timeit.timeit('''example.test(5)''',setup='import example', number=100)
py = 4
print(cy, py)
print('Cython is {}x faster'.format(py/cy))