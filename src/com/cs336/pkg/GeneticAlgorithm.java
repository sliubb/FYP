package com.cs336.pkg;

import java.util.Random;

/**
 * �Ŵ��㷨��
 * ������
 * 		1.run ��ʼ���㷨
 * 		2.createBeginningSpecies ������Ⱥ
 * 		3.calRate ����ÿһ�����ֱ�ѡ�еĸ���
 *      4.select  ���̲��� ѡ����Ӧ�ȸߵ�����
 *      5.crossover Ⱦɫ�彻��
 *      6.mutate Ⱦɫ�����
 *      7.getBest �����Ӧ����������
 */

public class GeneticAlgorithm {
	
	    //��ʼ�Ŵ�
		public SpeciesIndividual run(SpeciesPopulation list)
		{
			//������ʼ��Ⱥ
			//System.out.println("start createBeginningSpecies");
			createBeginningSpecies(list);
			//System.out.println("finish createBeginningSpecies");
			
			for(int i=1;i<=TSPData.DEVELOP_NUM;i++)
			{
				//ѡ��
			    //System.out.println("start select");
				select(list);
				//System.out.println("finish select");
				//����
				crossover(list);
				//System.out.println("finish crossover");
				//����
				mutate(list);
				//System.out.println("finish mutate");
			}	
			//SpeciesIndividual best = getBest(list);
			//System.out.println("finish getBest");
			return getBest(list);
		}
		
		//������ʼ��Ⱥ
		void createBeginningSpecies(SpeciesPopulation list)
		{
			/*
			//100%���
			int randomNum=(int)(TSPData.SPECIES_NUM);
			for(int i=1;i<=randomNum;i++)
			{
				SpeciesIndividual species=new SpeciesIndividual();//�������
				species.createByRandomGenes();//��ʼ��Ⱥ����
				list.add(species);//�������
				
			}
	*/		
			//40%̰��
			//System.out.println("start create");
			int greedyNum=TSPData.SPECIES_NUM;
			for(int i=1;i<=greedyNum;i++)
			{
				SpeciesIndividual species=new SpeciesIndividual();//�������
				species.createByGreedyGenes();//��ʼ��Ⱥ����
				//System.out.println("finish create");
				list.add(species);//�������
				//System.out.println("finish list");
			}
		}

		//����ÿһ���ֱ�ѡ�еĸ���
		void calRate(SpeciesPopulation list)
		{
			//��������Ӧ��
			float totalFitness=0.0f;
			list.speciesNum=0;
			SpeciesIndividual point=list.head.next;//�α�
			while(point != null)//Ѱ�ұ�β���
			{
				point.calFitness();//������Ӧ��
				
				totalFitness += point.fitness;
				list.speciesNum++;

				point=point.next;
			}

			//����ѡ�и���
			point=list.head.next;//�α�
			while(point != null)//Ѱ�ұ�β���
			{
				point.rate=point.fitness/totalFitness;
				point=point.next;
			}
		}
		
		//ѡ���������֣����̶ģ�
		void select(SpeciesPopulation list)
		{			
			//������Ӧ��
			//System.out.println("start cal");
			calRate(list);
			//System.out.println("finish cal");
			//�ҳ������Ӧ������
			double talentDis = 0.0d;
			SpeciesIndividual talentSpecies=null;
			SpeciesIndividual point=list.head.next;//�α�
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
			//�������Ӧ�����ָ���talentNum��
			SpeciesPopulation newSpeciesPopulation=new SpeciesPopulation();
			int talentNum=(int)(list.speciesNum/4);
			for(int i=1;i<=talentNum;i++)
			{
				//�����������±�
				SpeciesIndividual newSpecies=talentSpecies.clone();
				newSpeciesPopulation.add(newSpecies);
			}
			//System.out.println("first clone ");
			//���̶�list.speciesNum-talentNum��
			int roundNum=list.speciesNum-talentNum;
			for(int i=1;i<=roundNum;i++)
			{
				//����0-1�ĸ���
				double rate=(float)Math.random();
				
				SpeciesIndividual oldPoint=list.head.next;//�α�
				while(oldPoint != null && oldPoint != talentSpecies)//Ѱ�ұ�β���
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
					//�������һ��
					point=list.head;//�α�
					while(point.next != null)//Ѱ�ұ�β���
						point=point.next;
					SpeciesIndividual newSpecies=point.clone();
					newSpeciesPopulation.add(newSpecies);
				}
				
			}
			//System.out.println("finish list");
			list.head=newSpeciesPopulation.head;
		}
		
		//�������
		void crossover(SpeciesPopulation list)
		{
			//�Ը���pcl~pch����
			float rate=(float)Math.random();
			if(rate > TSPData.pcl && rate < TSPData.pch)
			{			
				SpeciesIndividual point=list.head.next;//�α�
				Random rand=new Random();
				int find=rand.nextInt(list.speciesNum);
				while(point != null && find != 0)//Ѱ�ұ�β���
				{
					point=point.next;
					find--;
				}
			
				if(point.next != null)
				{
					int begin=rand.nextInt(TSPData.CITY_NUM);

					//ȡpoint��point.next���н��棬�γ��µ�����Ⱦɫ��
					for(int i=begin;i<TSPData.CITY_NUM;i++)
					{
						//�ҳ�point.genes����point.next.genes[i]��ȵ�λ��fir
						//�ҳ�point.next.genes����point.genes[i]��ȵ�λ��sec
						int fir,sec;
						for(fir=0;!(point.genes[fir]==point.next.genes[i]);fir++);
						for(sec=0;!(point.next.genes[sec]==point.genes[i]);sec++);
						//�������򻥻�
						int tmp;
						tmp=point.genes[i];
						point.genes[i]=point.next.genes[i];
						point.next.genes[i]=tmp;
						
						//��ȥ�������ظ����Ǹ�����
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
		
		//�������
		void mutate(SpeciesPopulation list)
		{	
			//ÿһ���־��б���Ļ���,�Ը���pm����
			SpeciesIndividual point=list.head.next;
			while(point != null)
			{
				float rate=(float)Math.random();
				if(rate < TSPData.pm)
				{
					//Ѱ����ת���Ҷ˵�
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
					
					//��תleft-right�±�Ԫ��
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

		//�����Ӧ����������
		SpeciesIndividual getBest(SpeciesPopulation list)
		{
			double fit= 0.0d;
			SpeciesIndividual bestSpecies=null;
			SpeciesIndividual point=list.head.next;//�α�
			while(point != null)//Ѱ�ұ�β���
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


