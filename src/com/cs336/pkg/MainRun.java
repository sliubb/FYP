package com.cs336.pkg;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * ������������
 */

public class MainRun {
	public static void main(String[] args) throws SQLException {
		// TODO Auto-generated method stub
		//�����Ŵ��㷨��������
		GeneticAlgorithm GA=new GeneticAlgorithm();
		
		//������ʼ��Ⱥ
		SpeciesPopulation speciesPopulation = new SpeciesPopulation();

		//��ʼ�Ŵ��㷨��ѡ�����ӡ��������ӡ��������ӣ�
		SpeciesIndividual bestRate=GA.run(speciesPopulation);

		//��ӡ·������̾���
		bestRate.printRate();
	}

}


