import sys

file = sys.argv[1]
output = sys.argv[2]
size = sys.argv[3]
loc = sys.argv[4]
out = []
with open(file, 'r') as f:
  lines = f.readlines();
  
  for index, line in enumerate(lines):
      
    data = line.split(',')
    if index == 0:
      out.append(line)
    try:
      rowno = int(data[0])
      if index < 110:
        out.append(line)
      elif 110 <= index < 1e3:
        if int(rowno) < 1e3:
          if index % 5 == 0:
            if float(data[1]) > 1e-6:
              out.append(line)
        if int(rowno) >= 1e3:
          if float(data[1]) > 1e-6:
            out.append(line)
      elif 1e3 <= rowno <= 1e4:
        if float(data[1]) > 1e-6:
          if 'p' in file:
            if index % 10 == 0:
              out.append(line)
          else:
            if index % 2 == 0:
              out.append(line)
      elif 1e4 < rowno:
        if float(data[1]) > 1e-6:
          if size == 'large':
            if index % 100 == 0:
              out.append(line)
          else:
            if index % 2 == 0:
              out.append(line)
    except ValueError:
      pass

  lastline = lines[-1]
  out.append(lastline)


outfile = open(f"{loc}/{output}", 'w')
outfile.writelines(out)
outfile.close()
