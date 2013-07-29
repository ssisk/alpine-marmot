# rspec-core 2.14.4, rspec 2.14.1
require 'nokogiri'
require_relative 'alpine_marmot'

describe "AlpineMarmot", "#get_trkpts_in_gpx" do
	it "should work with an empty gpx" do 
	  expect {|b| AlpineMarmot.get_trkpts_in_gpx(gpx_no_trkpt, &b)}.not_to yield_control
	end

	it "should work with just 1 point" do 
	  points = []
	  AlpineMarmot.get_trkpts_in_gpx(gpx_one_trkpt) do |pt|
	  	points.push pt
	  end
	  expect(points.length).to eq(1)
	  expect(points[0]['lat']).to eq("57.0582268")
	end

	it "should work with multiple points in a segment" do 
	  points = []
	  AlpineMarmot.get_trkpts_in_gpx(gpx_multiple_trkpt) do |pt|
	  	points.push pt
	  end

	  expect(points.length).to eq(2)
	  expect(points[0]['lat']).to eq("57.0582268")
	  expect(points[1]['lon']).to eq("-25.0000000")
	end

	it "should work with multiple segments" do 
	  points = []
	  AlpineMarmot.get_trkpts_in_gpx(gpx_multiple_trkseg) do |pt|
	  	points.push pt
	  end

	  expect(points.length).to eq(2)
	  expect(points[0]['lat']).to eq("57.0582268")
	  expect(points[1]['lon']).to eq("-25.0000000")
	end

	let(:gpx_one_trkpt) do
		Nokogiri::XML::Document.parse <<-EOGPX
		  <?xml version="1.0" encoding="UTF-8" standalone="no" ?>
      <gpx xmlns="http://www.topografix.com/GPX/1/1" creator="MapSource 6.12.4" version="1.1" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="http://www.topografix.com/GPX/1/1 http://www.topografix.com/GPX/1/1/gpx.xsd">
        <trk>
          <name>My track</name>
    			<trkseg>
            <trkpt lat="57.0582268" lon="-135.3292810">
              <ele>18.8830566</ele>
              <time>2009-10-24T19:23:29Z</time>
            </trkpt>
          </trkseg>
        </trk>
      </gpx>
	  EOGPX
	end

	let(:gpx_multiple_trkseg) do
		Nokogiri::XML::Document.parse <<-EOGPX
		  <?xml version="1.0" encoding="UTF-8" standalone="no" ?>
      <gpx xmlns="http://www.topografix.com/GPX/1/1" creator="MapSource 6.12.4" version="1.1" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="http://www.topografix.com/GPX/1/1 http://www.topografix.com/GPX/1/1/gpx.xsd">
        <trk>
          <name>My track</name>
    			<trkseg>
            <trkpt lat="57.0582268" lon="-135.3292810">
              <ele>18.8830566</ele>
              <time>2009-10-24T19:23:29Z</time>
            </trkpt>
          </trkseg>
          <trkseg>
            <trkpt lat="43.0000000" lon="-25.0000000">
            </trkpt>
          </trkseg>
        </trk>
      </gpx>
	  EOGPX
	end

	let(:gpx_multiple_trkpt) do
		Nokogiri::XML::Document.parse <<-EOGPX
		  <?xml version="1.0" encoding="UTF-8" standalone="no" ?>
      <gpx xmlns="http://www.topografix.com/GPX/1/1" creator="MapSource 6.12.4" version="1.1" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="http://www.topografix.com/GPX/1/1 http://www.topografix.com/GPX/1/1/gpx.xsd">

        <trk>
          <name>My track</name>
    			<trkseg>
            <trkpt lat="57.0582268" lon="-135.3292810">
              <ele>18.8830566</ele>
              <time>2009-10-24T19:23:29Z</time>
            </trkpt>
            <trkpt lat="43.0000000" lon="-25.0000000">
            </trkpt>
          </trkseg>
        </trk>
      </gpx>
	  EOGPX
	end

	let(:gpx_no_trkpt) do 
		Nokogiri::XML::Document.parse <<-EOGPX
		  <?xml version="1.0" encoding="UTF-8" standalone="no" ?>
      <gpx xmlns="http://www.topografix.com/GPX/1/1" creator="MapSource 6.12.4" version="1.1" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="http://www.topografix.com/GPX/1/1 http://www.topografix.com/GPX/1/1/gpx.xsd">
      </gpx>
	  EOGPX
	end

end