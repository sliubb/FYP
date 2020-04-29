package com.cs336.pkg;

import java.util.Random;

/**
 * 遗传算法类
 * 包含：
 * 		1.run 开始跑算法
 * 		2.createBeginningSpecies 创建种群
 * 		3.calRate 计算每一种物种被选中的概率
 *      4.select  轮盘策略 选择适应度高的物种
 *      5.crossover 染色体交叉
 *      6.mutate 染色体变异
 *      7.getBest 获得适应度最大的物种
 */

public class GeneticAlgorithm {
	
	    //开始遗传
		public SpeciesIndividual run(SpeciesPopulation list)
		{
			//创建初始种群
			//System.out.println("start createBeginningSpecies");
			createBeginningSpecies(list);
			//System.out.println("finish createBeginningSpecies");
			
			for(int i=1;i<=TSPData.DEVELOP_NUM;i++)
			{
				//选择
			    //System.out.println("start select");
				select(list);
				//System.out.println("finish select");
				//交叉
				crossover(list);
				//System.out.println("finish crossover");
				//变异
				mutate(list);
				//System.out.println("finish mutate");
			}	
			//SpeciesIndividual best = getBest(list);
			//System.out.println("finish getBest");
			return getBest(list);
		}
		
		//创建初始种群
		void createBeginningSpecies(SpeciesPopulation list)
		{
			/*
			//100%随机
			int randomNum=(int)(TSPData.SPECIES_NUM);
			for(int i=1;i<=randomNum;i++)
			{
				SpeciesIndividual species=new SpeciesIndividual();//创建结点
				species.createByRandomGenes();//初始种群基因
				list.add(species);//添加物种
				
			}
	*/		
			//40%贪婪
			//System.out.println("start create");
			int greedyNum=TSPData.SPECIES_NUM;
			for(int i=1;i<=greedyNum;i++)
			{
				SpeciesIndividual species=new SpeciesIndividual();//创建结点
				species.createByGreedyGenes();//初始种群基因
				//System.out.println("finish create");
				list.add(species);//添加物种
				//System.out.println("finish list");
			}
		}

		//计算每一物种被选中的概率
		void calRate(SpeciesPopulation list)
		{
			//计算总适应度
			float totalFitness=0.0f;
			list.speciesNum=0;
			SpeciesIndividual point=list.head.next;//游标
			while(point != null)//寻找表尾结点
			{
				point.calFitness();//计算适应度
				
				totalFitness += point.fitness;
				list.speciesNum++;

				point=point.next;
			}

			//计算选中概率
			point=list.head.next;//游标
			while(point != null)//寻找表尾结点
			{
				point.rate=point.fitness/totalFitness;
				point=point.next;
			}
		}
		
		//选择优秀物种（轮盘赌）
		void select(SpeciesPopulation list)
		{			
			//计算适应度
			//System.out.println("start cal");
			calRate(list);
			//System.out.println("finish cal");
			//找出最大适应度物种
			double talentDis = 0.0d;
			SpeciesIndividual talentSpecies=null;
			SpeciesIndividual point=list.head.next;//游标
			//System.out.println("first choose ");
			while(point!=null)
			{
				if(talentDis <= point.fitness)
				{
					talentDis=point.fitness;
					talentSpecies=point;
				}
				point=point.next;
			}
			//System.out.println("choose best");
			if(talentSpecies==null) {
				System.out.println("failed choose best");
			}
			//将最大适应度物种复制talentNum个
			SpeciesPopulation newSpeciesPopulation=new SpeciesPopulation();
			int talentNum=(int)(list.speciesNum/4);
			for(int i=1;i<=talentNum;i++)
			{
				//复制物种至新表
				SpeciesIndividual newSpecies=talentSpecies.clone();
				newSpeciesPopulation.add(newSpecies);
			}
			//System.out.println("first clone ");
			//轮盘赌list.speciesNum-talentNum次
			int roundNum=list.speciesNum-talentNum;
			for(int i=1;i<=roundNum;i++)
			{
				//产生0-1的概率
				double rate=(float)Math.random();
				
				SpeciesIndividual oldPoint=list.head.next;//游标
				while(oldPoint != null && oldPoint != talentSpecies)//寻找表尾结点
				{
					if(rate <= oldPoint.rate)
					{
						SpeciesIndividual newSpecies=oldPoint.clone();
						newSpeciesPopulation.add(newSpecies);
						
						break;
					}
					else
					{
						rate=rate-oldPoint.rate;
					}
					oldPoint=oldPoint.next;
				}
				
				if(oldPoint == null || oldPoint == talentSpecies)
				{
					//复制最后一个
					point=list.head;//游标
					while(point.next != null)//寻找表尾结点
						point=point.next;
					SpeciesIndividual newSpecies=point.clone();
					newSpeciesPopulation.add(newSpecies);
				}
				
			}
			//System.out.println("finish list");
			list.head=newSpeciesPopulation.head;
		}
		
		//交叉操作
		void crossover(SpeciesPopulation list)
		{
			//以概率pcl~pch进行
			float rate=(float)Math.random();
			if(rate > TSPData.pcl && rate < TSPData.pch)
			{			
				SpeciesIndividual point=list.head.next;//游标
				Random rand=new Random();
				int find=rand.nextInt(list.speciesNum);
				while(point != null && find != 0)//寻找表尾结点
				{
					point=point.next;
					find--;
				}
			
				if(point.next != null)
				{
					int begin=rand.nextInt(TSPData.CITY_NUM);

					//取point和point.next进行交叉，形成新的两个染色体
					for(int i=begin;i<TSPData.CITY_NUM;i++)
					{
						//找出point.genes中与point.next.genes[i]相等的位置fir
						//找出point.next.genes中与point.genes[i]相等的位置sec
						int fir,sec;
						for(fir=0;!(point.genes[fir]==point.next.genes[i]);fir++);
						for(sec=0;!(point.next.genes[sec]==point.genes[i]);sec++);
						//两个基因互换
						int tmp;
						tmp=point.genes[i];
						point.genes[i]=point.next.genes[i];
						point.next.genes[i]=tmp;
						
						//消去互换后重复的那个基因
						point.genes[fir]=point.next.genes[i];
						point.next.genes[sec]=point.genes[i];
						
					}
				}
			}
			/*
			SpeciesIndividual p=list.head.next;
			while(p != null) {
				int total = 0;
				for(int i = 0; i < p.genes.length; i++) {
					if(p.genes[i] == 1) {
						if(total + TSPData.citys.get(i).getDuration() <= TSPData.hours) {
							total = total + TSPData.citys.get(i).getDuration();
						}else {
							p.genes[i] = 0;
						}
					}
				}
			}
			*/
		}
		
		//变异操作
		void mutate(SpeciesPopulation list)
		{	
			//每一物种均有变异的机会,以概率pm进行
			SpeciesIndividual point=list.head.next;
			while(point != null)
			{
				float rate=(float)Math.random();
				if(rate < TSPData.pm)
				{
					//寻找逆转左右端点
					Random rand=new Random();
					int left=rand.nextInt(TSPData.CITY_NUM);
					int right=rand.nextInt(TSPData.CITY_NUM);
					if(left > right)
					{
						int tmp;
						tmp=left;
						left=right;
						right=tmp;
					}
					
					//逆转left-right下标元素
					while(left < right)
					{
						int tmp;
						tmp=point.genes[left];
						point.genes[left]=point.genes[right];
						point.genes[right]=tmp;

						left++;
						right--;
					}
				}
				point=point.next;
			}
			/*
			SpeciesIndividual p=list.head.next;
			while(p != null) {
				int total = 0;
				for(int i = 0; i < p.genes.length; i++) {
					if(p.genes[i] == 1) {
						if(total + TSPData.citys.get(i).getDuration() <= TSPData.hours) {
							total = total + TSPData.citys.get(i).getDuration();
						}else {
							p.genes[i] = 0;
						}
					}
				}
			}
			*/
		}

		//获得适应度最大的物种
		SpeciesIndividual getBest(SpeciesPopulation list)
		{
			double fit= 0.0d;
			SpeciesIndividual bestSpecies=null;
			SpeciesIndividual point=list.head.next;//游标
			while(point != null)//寻找表尾结点
			{
				point.calFitness();
				//System.out.println(point.fitness);
				if(fit <= point.fitness)
				{
					bestSpecies=point;
					fit=point.fitness;
				}

				point=point.next;
			}
			//for(int i = 0; i< bestSpecies.genes.length;i++)
				//System.out.println(bestSpecies.genes[i]);
			int total = 0;
			for(int i = 0; i < bestSpecies.genes.length; i++) {
				if(bestSpecies.genes[i] == 1) {
					if(total + TSPData.citys.get(i).getDuration() <= TSPData.hours) {
						total = total + TSPData.citys.get(i).getDuration();
					}else {
						bestSpecies.genes[i] = 0;
					}
				}
			}
			int totalP = 0;
			for(int i = 0; i < bestSpecies.genes.length; i++) {
				if(bestSpecies.genes[i] == 1) {
					if(totalP + TSPData.citys.get(i).getPrice() <= TSPData.maxprice) {
						totalP = totalP + TSPData.citys.get(i).getPrice();
					}else {
						bestSpecies.genes[i] = 0;
					}
				}
			}
			return bestSpecies;
		}

}


