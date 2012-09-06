# encoding: utf-8

class Guide < ActiveRecord::Base

  validates_presence_of :name, :user_id, :parent_id
  validates_uniqueness_of :name

  belongs_to :user

  scope :list_display, where(:is_show => true)

  acts_as_tree :order => 'sequence ASC'

  # the root guide ---- parent_id
  TOP_COLS = -1

  def author
    user.name
  end

  def parent
    if parent_id == -1 || parent_id == nil
      return ''
    end

    guide = Guide.find_by_id(parent_id)
    return guide.name
  end

  def display
    case is_show
    when DictionaryEntity::DISPLAY_MAP[I18n.t('common.display.show')] then I18n.t('common.display.show')
    when DictionaryEntity::DISPLAY_MAP[I18n.t('common.display.hide')] then I18n.t('common.display.hide')
    end
  end
  
  def uri_path
    if uri.blank?
      return '/'
    end
    uri
  end

end
