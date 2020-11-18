class Period < ActiveHash::Base
  self.data = [
    { id: 1, name: '--' },
    { id: 2, name: '7日間' },
    { id: 3, name: '21日間' },
    { id: 4, name: '90日間' }
  ]
end
