map ^func ^array = {
  result = []
  array.each ^item (
    result.append: func item
  )
  return result
}

filter ^func ^array = {
  result = []
  array.each ^item (
    if (func item) ^(
      result.append item
    )
  )
  return result
}

reduce ^func ^array ^acc = {
  if (array.has 0) ^!(
    return: reduce func (rest array) (func (first array) acc)
  )
  return acc
}

select ^func ^array = {
  result = []
  array.each ^item (
    if (func item) ^(
      result.append item
    )
  )
  return result
}

reject ^func ^array = {
  select ^item (return: !(func item)) array
}

all ^func ^array = {
  array.each ^!item (
    if (!(func item)) ^!(
      return null
    )
  )
  return true
}

detect ^func ^array = {
  array.each ^!item (
    if (func item) ^!(
      return item
    )
  )
  return null
}

any = detect

zip ^a1 ^a2 = {
  zipWith ^a ^b (
    result = []
    result.append a
    result.append b
    return result
  ) a1 a2
}

zipWith ^func ^a1 ^a2 = {
  result = []
  count = 0
  while ^(count < a1.count) ^(
    result.append: func (a1 count) (a2 count)
    count = count + 1
  )
  return result
}

drop ^n ^array = {
  if (n == 0) ^!(
    return array
  )
  return: drop (n-1) (rest array)
}

rev ^array = {
  result = []
  array.each ^item (
    result = prepend item result
  )
  return result
}

tail = drop 1

end ^array = {
  return: array ((array.count) - 1)
}

merge ^a1 ^a2 = {
  result = []
  a1.each ^item (
    result.append item
  )

  a2.each ^item (
    result.append item
  )
  return result
}

prepend ^a ^array = {
  result = []
  result.append a
  array.each ^item (
    result.append item
  )
  return result
}

take ^n ^array = {
  if (n == 0) ^!(
    return []
  )
  return: prepend (first array) (take (n-1) (rest array))
}

first ^array = {
  array.each ^!item (
    return item
  )
}

init ^array = {
  take ((array.count) - 1) array
}

rest ^array = {
  result = []
  count = 0
  array.each ^item (
    if (count != 0) ^(
      result.append item
    )

    if (count == 0) ^(
      count = count + 1
    )
  )
  return result
}

weirdIdentity ^identify = {
  obj = []
  obj.append reduce
  return: obj 0 ^a ^b (return: a + b) obj 0 identify
}

natural = ^(
  result = []
  item = 0
  loop ^(
    result.append item
    item = item + 1
  )
  return result
)

enum = [
  genArg = null
  gen ^a ^obj = {return this.genArg}
  create ^generator ^start = {
    result = [
      parent = enum
    ]
    result.gen = generator
    result.genArg = start
    return result
  }

  next ^ = {
    result = this.gen (this.genArg) this
    if (result) ^!(
      return result
    )
    return null
  }

  force ^ = {
    self = this
    obj = [parent = self]
    result = []
    theNext = do: obj.next
    while ^(theNext) ^(
      result.append theNext
      theNext = do: obj.next
    )
    return: result
  }

  take ^a = {
    self = this
    obj = [parent = self]
    result = []
    count = 0
    while ^(count < a) ^(
      result.append (do: obj.next)
      count = count + 1
    )

    return: result
  }
]
