COMMAND_MAP = {
  'lights' => ['on', 'off', 'max', 'min', 'white', 'warm', 'up', 'down'],
  'air'    => ['heat', 'cool', 'off']
}

def item_xml(options = {})
  <<-ITEM
  <item arg="#{options[:arg]}" uid="#{options[:uid]}">
    <title>#{options[:title]}</title>
    <subtitle>#{options[:subtitle]}</subtitle>
    <icon>#{options[:icon_path]}</icon>
  </item>
  ITEM
end

items = COMMAND_MAP.map { |device, commands|
  commands.map do |command|
    device_command = "#{device}:#{command}"
    input_command  = ARGV.first.to_s.split(' ')[0]
    next if !device_command.match(/#{input_command}/)
    item_xml(arg: device_command, uid: device_command, title: device_command, icon_path: "#{device}.png")
  end.compact.join
}.compact.join

puts "<?xml version='1.0'?><items>#{items}</items>"