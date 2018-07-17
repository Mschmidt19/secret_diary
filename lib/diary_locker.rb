class DiaryLocker
  def unlock(diary)
    diary.locked = false
    puts "Diary unlocked"
  end
  def lock(diary)
    diary.locked = true
    puts "Diary locked"
  end
end
