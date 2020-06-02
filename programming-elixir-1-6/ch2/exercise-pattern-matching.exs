# -- Exercise 1

# will match
a = 4
a = [[1, 2, 3]]
[a] = [[1, 2, 3]]

# will not match
a = [1, 2, 3]
4 = a
[a, b] = [1, 2, 3]
[[a]] = [[1, 2, 3]]

# -- Exercise 2

# will match
a = 1
^a = 1
^a = 2 - a

# will not match
[a, b, a] = [1, 2, 3]
[a, b, a] = [1, 1, 2]
^a = 2

