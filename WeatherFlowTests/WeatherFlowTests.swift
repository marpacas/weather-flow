//
//  WeatherFlowTests.swift
//  WeatherFlowTests
//
//  Created by Martha Castillo on 6/25/19.
//
//

import XCTest
@testable import WeatherFlow

class CurrentWeatherParserTests: XCTestCase {

    var inputJSONOne: [String: AnyObject] = [:]
    var inputJSONTwo: [String: AnyObject] = [:]
    
    override func setUp() {
        super.setUp()
        
        let dataOne = "{ \"one\": 42.0, \"main\": \"hello\" }".data(using: String.Encoding.utf8)!

        self.inputJSONOne = try! JSONSerialization.jsonObject(with: dataOne, options: []) as! [String : AnyObject]
        
        let dataTwo = "{\"weather\":[{\"description\":\"sunny\",\"icon\":\"d10\"}],\"main\":{\"temp\":24.83,\"humidity\":78},\"cod\":200}".data(using: String.Encoding.utf8)!

        self.inputJSONTwo = try! JSONSerialization.jsonObject(with: dataTwo, options: []) as! [String : AnyObject]

    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    
    func testParseNonJSONString() {
        let parser = WFWeatherConditionParser(JSONObjectToParse:"Not a JSON" as AnyObject)
        guard case .error = parser.parseJSONObject() else {
            XCTFail("Weather Parser couldn't recognize invalid JSON Object")
            return
        }
    }
    
 
    func testParseJSONWithUnexpectedValues() {
        let parserOne = WFWeatherConditionParser(JSONObjectToParse: inputJSONOne as AnyObject)
        guard case .error = parserOne.parseJSONObject() else {
            XCTFail("Weather Parser couldn't recognize JSON with unexpected values")
            return
        }
    }
    
    func testParseValidJSON() {
        let parserTwo = WFWeatherConditionParser(JSONObjectToParse: inputJSONTwo as AnyObject)
        
        guard case let .success(conditions) = parserTwo.parseJSONObject() else {
            XCTFail("Valid JSON was not parsed successfully by Weather Parser")
            return
        }
        XCTAssertEqual(78, conditions.humidity)
        XCTAssertEqual(24.83, conditions.temperature)
        XCTAssertEqual("sunny", conditions.conditionDescription)
        XCTAssertEqual("http://openweathermap.org/img/w/d10.png", conditions.iconURL!)
        
    }

    
}


class ForecastParserTests: XCTestCase {
    
    var inputJSONOne: [String: AnyObject] = [:]
    var inputJSONTwo: [String: AnyObject] = [:]
    
    override func setUp() {
        super.setUp()
        
        let dataOne = "{ \"one\": 42.0, \"main\": \"hello\" }".data(using: String.Encoding.utf8)!
        
        self.inputJSONOne = try! JSONSerialization.jsonObject(with: dataOne, options: []) as! [String : AnyObject]
        
        let dataTwo = "{\"dt_txt\":\"2019-06-25 06:00:00\",\"weather\":[{\"description\":\"sunny\",\"icon\":\"d15\"}],\"main\":{\"temp\":24.83,\"humidity\":78,\"temp_min\":18.00,\"temp_max\":28.00},\"cod\":200}".data(using: String.Encoding.utf8)!
        
        self.inputJSONTwo = try! JSONSerialization.jsonObject(with: dataTwo, options: []) as! [String : AnyObject]
        
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    
    func testParseNonJSONString() {
        let parser = WFForecastParser(JSONObjectToParse:"Not a JSON" as AnyObject)
        guard case .error = parser.parseJSONObject() else {
            XCTFail("Forecast Parser couldn't recognize invalid JSON Object")
            return
        }
    }
    
      
    func testParseValidJSON() {
        let parserTwo = WFForecastParser(JSONObjectToParse: inputJSONTwo as AnyObject)
        
        guard case let .success(forecast) = parserTwo.parseJSONObject() else {
            XCTFail("Valid JSON was not parsed successfully by Forecast Parser ")
            return
        }
        XCTAssertEqual("2019-06-25 06:00:00", forecast.textDate)
        XCTAssertEqual(78, forecast.condition?.humidity)
        XCTAssertEqual(24.83, forecast.condition?.temperature)
        XCTAssertEqual("sunny", forecast.condition?.conditionDescription)
        XCTAssertEqual("http://openweathermap.org/img/w/d15.png", forecast.condition?.iconURL!)
        XCTAssertEqual(18.00, forecast.minTemperature)
        XCTAssertEqual(28.00, forecast.maxTemperature)
        
    }
    
    
}
