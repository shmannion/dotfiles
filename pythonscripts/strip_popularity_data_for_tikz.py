import sys


if __name__ == "__main__":
    file = sys.argv[1]
    output = sys.argv[2]
    loc = sys.argv[3]
    out = []
    k_vals = [i for i in range(1, 80)]
    k_vals += [i for i in range(80,1000, 5)]
    k_vals += [i for i in range(1000,10000, 10)]
    k_vals += [i for i in range(10000,int(1e7), 100)]
    out.append('k, p\n')
    with open(file, 'r') as f:
        lines = f.readlines();
        for index, line in enumerate(lines):
            data = line.split(',')
            # if index == 0:
            #     out.append(line)
            #     continue
            try:
                k = int(data[0])
                if len(k_vals) > 0 and k >= k_vals[0]:
                    out.append(line)
                    while len(k_vals) > 0 and k >= k_vals[0]:
                        k_vals.pop(0)
            except ValueError:
                continue

    lastline = lines[-1]
    out.append(lastline)
    out.append(lastline)
    out.append(lastline)


outfile = open(f"{loc}/{output}", 'w')
outfile.writelines(out)
outfile.close()
