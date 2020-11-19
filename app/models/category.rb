class Category < ActiveHash::Base
  self.data = [
    { id: 1, name: '--' },
    { id: 2, name: '早起き' },
    { id: 3, name: '体重管理' },
    { id: 4, name: 'マインドフルネス' },
    { id: 5, name: '筋トレ' },
    { id: 6, name: '健康・美容' },
    { id: 7, name: '睡眠をとる' },
    { id: 8, name: 'ウォーキング' }
  ]
end
