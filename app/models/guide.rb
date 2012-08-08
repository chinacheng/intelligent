class Guide < ActiveRecord::Base

  validates_presence_of :name, :user_id, :parent_id
  validates_uniqueness_of :name

  belongs_to :user

  acts_as_tree :order => "sequence ASC"

  # the root guide ---- parent_id
  TOP_COLS = -1

  def author
    user = User.find_by_id(user_id)
    return user.name
  end

  def parent
    if parent_id == -1 || parent_id == nil
      return ""
    end

    guide = Guide.find_by_id(parent_id)
    return guide.name
  end

  def display
    case is_show
    when DictionaryEntity::DISPLAY_MAP[I18n.t("common.display.show")] then I18n.t("common.display.show")
    when DictionaryEntity::DISPLAY_MAP[I18n.t("common.display.hide")] then I18n.t("common.display.hide")
    end
  end


  def self.list_display
    Guide.find_all_by_is_show(true)
  end
  
  def uri_path
    if uri.blank?
      return "/"
    end
    uri
  end

end
