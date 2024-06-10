# frozen_string_literal: true

module ApplicationHelper
  def horizontal_padding
    "px-4 sm:px-6 lg:px-8"
  end

  def table(&block)
    tag.div class: "flex flex-col mt-5" do
      tag.div class: "-my-2 overflow-x-auto sm:-mx-6 lg:-mx-8" do
        tag.div class: "py-2 align-middle inline-block min-w-full sm:px-6 lg:px-8" do
          tag.div class: "shadow overflow-hidden border-b border-gray-200 sm:rounded-lg" do
            tag.table class: "min-w-full divide-y divide-gray-200" do
              capture(&block)
            end
          end
        end
      end
    end
  end
end
