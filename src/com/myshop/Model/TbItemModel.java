package com.myshop.Model;

public class TbItemModel {
 private int ItemId;
 private String itemBarcode;
 private String itemName;
 private double itemCost;
 private double itemPrice;
 private int itemStock;
 private String timeReg;
 
 public void setItemId(int ItemId) {
	 this.ItemId = ItemId;
 }
 public int getItemId() {
	 return ItemId;
 }
public String getItemBarcode() {
	return itemBarcode;
}
public void setItemBarcode(String itemBarcode) {
	this.itemBarcode = itemBarcode;
}
public String getItemName() {
	return itemName;
}
public void setItemName(String itemName) {
	this.itemName = itemName;
}
public double getItemCost() {
	return itemCost;
}
public void setItemCost(double itemCost) {
	this.itemCost = itemCost;
}
public double getItemPrice() {
	return itemPrice;
}
public void setItemPrice(double itemPrice) {
	this.itemPrice = itemPrice;
}
public int getItemStock() {
	return itemStock;
}
public void setItemStock(int itemStock) {
	this.itemStock = itemStock;
}
public String getTimeReg() {
	return timeReg;
}
public void setTimeReg(String timeReg) {
	this.timeReg = timeReg;
}
 
 
}
