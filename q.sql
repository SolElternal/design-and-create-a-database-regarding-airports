#"หาจำนวนผู้โดยสารทั้งหมดของแต่ละเที่ยวบินที่มีเวลาออกไปในช่วงเช้า (ระหว่าง 06:00 ถึง 12:00) โดยแสดงผลลัพธ์ตามจำนวนผู้โดยสารจากมากไปน้อย"
#แสดงรหัสเที่ยวบิน (flightID) และจำนวนผู้โดยสารทั้งหมด (passenger_count) ของแต่ละเที่ยวบินในช่วงเช้า (ระหว่าง 06:00 ถึง 12:00) และในช่วงเย็น (12:01 ถึง 18:00) โดยแบ่งตามช่วงเวลาและเรียงลำดับตามจำนวนผู้โดยสารจากมากไปน้อย
SELECT Flights.flightID, COUNT(Tickets.passengerID) AS passenger_count,
    CASE
        WHEN TIME(Flights.departureTime) BETWEEN '06:00:00' AND '12:00:00' THEN 'Morning'
        ELSE 'Afternoon'
    END AS time_range
FROM Flights
    INNER JOIN Tickets ON Flights.flightID = Tickets.flightID
GROUP BY Flights.flightID, time_range
HAVING passenger_count>10
ORDER BY flights.flightID;


#อยากทราบว่าจุดหมายปลายทางที่มีจำนวนคนไปมากที่สุด ไปโดยสายการบินใด และส่วนใหญ่ไปขึ้นต้นทางที่สนามบินใด จังหวัดใด
select f.destination, count(t.passengerID) as amount_passenger, c.companyName, air.airportName, air.province
from flights f
	inner join tickets t on f.flightID = t.flightID
	inner join airplanes a on f.airplaneID = a.airplaneID
    inner join companies c on a.companyID = c.companyID
    inner join involvement i on c.companyID = i.companyID
    inner join airport air on i.airportID = air.airportID
group by f.destination, c.companyName, air.airportName, air.province
limit 0,1; 


#หาจำนวนผู้โดยสารที่จองตั๋วเที่ยวบินในแต่ละบริษัท และแสดงบริษัทที่มีจำนวนผู้โดยสารมากกว่า 30 คน
SELECT Companies.companyName, COUNT(Tickets.passengerID) AS passenger_count
FROM Companies
	INNER JOIN Airplanes ON Companies.companyID = Airplanes.companyID
	INNER JOIN Flights ON Airplanes.airplaneID = Flights.airplaneID
	INNER JOIN Tickets ON Flights.flightID = Tickets.flightID
GROUP BY Companies.companyName
HAVING passenger_count > 30
ORDER BY passenger_count DESC;

#เนื่องจากมีผู้ต้องสงสัยจำนวน 3 คน ชื่อ Daniel Martinez สัญชาติสเปน, Olivia Taylor สัญชาติแคนนาดา , Lucas Wilson 
#สัญชาติสเปน ถูกต้องสงสัยว่าเป็นนักโทษหลบหนีได้ปลอมแปลงเอกสารการเดินทาง ทำให้ตม.และตำรวจไม่สามารถตรวจสอบได้เป็นจำนวนหลายครั้ง และตำรวจต้องการทราบประวิติการเดินของนักโทษกลุ่มดังกล่าว 
#โดยต้องการทราบว่ากลุ่มคนดังกล่าวเดินทางไปที่ใด ด้วยสายการบินใด เวลาขึ้นเครื่องเท่าไร เวลาลงเครื่องเท่าไร ขึ้นเครื่องบินต้นทางจากที่ใด รหัสเที่ยวบิน เลขประตูขึ้นเครื่อง ชนิดที่นั่ง รหัสที่นั่ง รหัสผู้โดยสาร ชื่อ-นามสุกล สัญชาติ และน้ำหนักกระเป๋า 
#เนื่องจากในกระเป๋าอาจจะมีวัตถุต้องสงสัย 
select p.passengerID, p.passengerName, p.nationality , p.weigthBeg , t.check_in , t.flightID , t.gate_number , t.type_seat , t.seat_number , f.flightID, f.destination, f.departureTime ,f.arrivalTime , a.airplaneID , a.airplaneName, air.airportName, c.companyName
from Passengers p
 inner join tickets t on t.passengerID = p.passengerID
 inner join Flights f on f.flightID = t.flightID 
 inner join airplanes a on f.airplaneID = a.airplaneID
 inner join companies c on a.companyID = c.companyID
 inner join involvement i on c.companyID = i.companyID
 inner join airport air on i.airportID = air.airportID
where p.passengerName = 'Daniel Martinez' 
 or p.passengerName = 'Olivia Taylor' 
    or p.passengerName = 'Lucas Wilson'
order by t.check_in;

#อยากทราบว่าเมื่อเวลาผ่านไป 10 บริษัทไหนมีจำนวนผู้โดยสารงานมากที่สุด และบริษัทนั้นต้องจ่ายเงินเดือนรวมกันให้กับพนักงานตำแหน่งละกี่บาท ตำแน่งงานไหนได้เงินเเดือนยอะที่สุด
select c.companyName, count(e.JobPositions), sum(e.salary*10*12) as sum_salary_10YEARS_isPaid, e.JobPositions, e.salary
from passengers p
	inner join tickets t on p.passengerID = t.passengerID
    inner join flights f on t.flightID = f.flightID
    inner join airplanes a on f.airplaneID = a.airplaneID
    inner join companies c on a.companyID = c.companyID
    inner join employeesflight et on f.flightID = et.flightID
    inner join employees e on et.employeesID = e.employeesID
group by e.JobPositions, e.salary, c.companyName;
