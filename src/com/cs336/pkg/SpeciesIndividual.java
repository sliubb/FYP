package com.cs336.pkg;

import java.util.Random;

/**
 * 个体类
 * 包含：
 * 		1.createByRandomGenes 初始物种基因(随机) 基因直接用城市序列编码
 * 		2.calFitness 计算物种适应度
 * 		3.printRate 打印路径
 */

public class SpeciesIndividual {
	
	public int[] genes;//基因序列
	float distance;//路程
	double fitness;//适应度
	SpeciesIndividual next;
	double rate;
	static float m = 0.5f;
	static float n = 0.5f;
	static float k = 0.5f;
	SpeciesIndividual()
	{
		//初始化
		this.genes= new int[TSPData.CITY_NUM];
		this.fitness=0.0f;
		this.distance=0.0f;
		this.next= null;
		rate=0.0f;
	}
	//初始物种基因(随机)
	void createByRandomGenes()
	{
		//初始化基因为1-CITY_NUM序列
		for(int i = 0;i < this.genes.length;i++)
		{
			this.genes[i]=0;
		}
		
		//获取随机种子
		Random rand=new Random();

		for(int j=0;j<this.genes.length;j++)
		{
			if(rand.nextBoolean()) {
				this.genes[j] = 1;
			}
		}
	}
	
	//初始物种基因(贪婪)
	void createByGreedyGenes()
	{
		int totalHours = 0;
		int point = TSPData.point;
		if(TSPData.point >= this.genes.length) {
			point = 0;
			TSPData.point = 0;
		}
		//System.out.println(point);
		for(int i = 0;i < this.genes.length;i++)
		{
			this.genes[i]=0;
		}
		//System.out.println(TSPData.hours);
		if((totalHours + TSPData.citys.get(point).getDuration() > TSPData.hours)&& totalHours == 0) {
			TSPData.point++;
			point++;
		}
		if(TSPData.point >= this.genes.length) {
			point = 0;
			TSPData.point = 0;
		}
		while((totalHours + TSPData.citys.get(point).getDuration() <= TSPData.hours))
		{
			genes[point] = 1;			
			totalHours = totalHours + TSPData.citys.get(point).getDuration();
			point++;
			TSPData.point++;
			if(TSPData.point >= this.genes.length) {
				point = 0;
				TSPData.point = 0;
			}
			if((point < this.genes.length) && (totalHours + TSPData.citys.get(point).getDuration() > TSPData.hours)&& totalHours == 0) {
				TSPData.point++;
			}
		};
		//System.out.println(totalHours);
	}
	
	//计算物种适应度
	void calFitness()
	{
		for(int i = 0;i < this.genes.length;i++)
		{
			if(genes[i] == 1) {
				double f = TSPData.maxprice/(1+TSPData.minprice+TSPData.citys.get(i).getPrice());
				double g = TSPData.citys.get(i).getPopularity()
						+ TSPData.citys.get(i).getAcitivity()*TSPData.acitivity
						+ TSPData.citys.get(i).getAmusementPark()*TSPData.amusementPark
						+ TSPData.citys.get(i).getCulture()*TSPData.culture
						+ TSPData.citys.get(i).getHistory()*TSPData.history
						+ TSPData.citys.get(i).getNature()*TSPData.nature
						+ TSPData.citys.get(i).getOther()*TSPData.other
						+ TSPData.citys.get(i).getOutdoor()*TSPData.outdoor
						+ TSPData.citys.get(i).getShopping()*TSPData.shopping;
				double fit = (1-m) * Math.pow(f, n) + Math.pow(g, k);
				this.fitness += fit;
			}
		}
	}
	
	//深拷贝
	public SpeciesIndividual clone()
	{	
		SpeciesIndividual species=new SpeciesIndividual();
		
		//复制值
		for(int i=0;i<this.genes.length;i++)
			species.genes[i]=this.genes[i];
		species.fitness=this.fitness;
	
		return species;	
	}
	
	//打印路径
	public double calBest() {
		double best = 0.0d;
		for(int i=0; i<this.genes.length;i++) {
			if(this.genes[i] == 1) {
				double f = TSPData.maxprice/(1+TSPData.minprice+TSPData.citys.get(i).getPrice());
				double g = TSPData.citys.get(i).getPopularity()
						+ TSPData.citys.get(i).getAcitivity()*TSPData.acitivity
						+ TSPData.citys.get(i).getAmusementPark()*TSPData.amusementPark
						+ TSPData.citys.get(i).getCulture()*TSPData.culture
						+ TSPData.citys.get(i).getHistory()*TSPData.history
						+ TSPData.citys.get(i).getNature()*TSPData.nature
						+ TSPData.citys.get(i).getOther()*TSPData.other
						+ TSPData.citys.get(i).getOutdoor()*TSPData.outdoor
						+ TSPData.citys.get(i).getShopping()*TSPData.shopping;
				double fit = (1-m) * Math.pow(f, n) + Math.pow(g, k);
				if(fit > best) {
					best = fit;
				}
			}
		}
		return best;
	}
	public double calAvg() {
		double avg = 0.0d;
		int num = 0;
		for(int i=0; i<this.genes.length;i++) {
			if(this.genes[i] == 1) {
				num++;
				double f = TSPData.maxprice/(1+TSPData.minprice+TSPData.citys.get(i).getPrice());
				double g = TSPData.citys.get(i).getPopularity()
						+ TSPData.citys.get(i).getAcitivity()*TSPData.acitivity
						+ TSPData.citys.get(i).getAmusementPark()*TSPData.amusementPark
						+ TSPData.citys.get(i).getCulture()*TSPData.culture
						+ TSPData.citys.get(i).getHistory()*TSPData.history
						+ TSPData.citys.get(i).getNature()*TSPData.nature
						+ TSPData.citys.get(i).getOther()*TSPData.other
						+ TSPData.citys.get(i).getOutdoor()*TSPData.outdoor
						+ TSPData.citys.get(i).getShopping()*TSPData.shopping;
				double fit = (1-m) * Math.pow(f, n) + Math.pow(g, k);
				avg = avg+fit;
			}
		}
		return avg/num;
	}
	public void printRate()
	{
		System.out.print("Recommended itinerary：");
		for(int i=0; i<this.genes.length;i++) {
			if(this.genes[i] == 1) {
				System.out.println(TSPData.citys.get(i).getName());
			}
		}
	}

}


