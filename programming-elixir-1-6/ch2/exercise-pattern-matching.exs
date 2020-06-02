# will match
a = 4
a = [[1, 2, 3]]
[a] = [[1, 2, 3]]

# will not match
a = [1, 2, 3]
4 = a
[a, b] = [1, 2, 3]
[[a]] = [[1, 2, 3]]
