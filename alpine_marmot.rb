

#f = File.open('test.gpx')

#doc = Nokogiri::XML(f)

module AlpineMarmot

 	Point = Struct.new(:lat, :lon, :ele, :time)

 	# return a nicer, not-xml-y struct
 	def self.trkpt_to_point trkpt
 			Point.new(trkpt['lat'], trkpt['lon'], trkpt['ele'], trkpt['time'])
 	end

 	def self.get_trkpts_in_gpx(gpx, &b)
 		get_trks_in_gpx(gpx) do |trk| 
 		  get_trksegs_in_trk(trk) do |trkseg| 
 		    get_trkpts_in_trkseg(trkseg, &b)
 		  end
 	  end
  end

  def self.get_trks_in_gpx(gpx)
  	gpx.remove_namespaces!
  	gpx.xpath('/gpx/trk').each {|node| yield node }
  end

  def self.get_trksegs_in_trk(trk_node)
  	trk_node.xpath('trkseg').each {|trkseg| yield trkseg }
  end

  def self.get_trkpts_in_trkseg(trkseg_node)
  	trkseg_node.xpath('trkpt').each {|trkpt| yield trkpt }
  end
end
