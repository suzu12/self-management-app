class Period < ActiveHash::Base
  self.data = [
    { id: 1, name: '--' },
    { id: 2, name: '3日間' },
    { id: 3, name: '7日間' },
    { id: 4, name: '10日間' },
    { id: 5, name: '21日間' },
    { id: 6, name: '30日間' },
    { id: 7, name: '60日間' },
    { id: 8, name: '90日間' }
  ]
end
