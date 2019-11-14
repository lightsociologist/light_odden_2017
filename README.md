# Code for Light and Odden (2017)

Author: Ryan Light

This repository contains the data and code for:

[Light, R., & Odden, C. (2017). Managing the boundaries of taste: culture, valuation, and computational social science. Social Forces, 96(2), 877-908.] (https://cpb-us-e1.wpmucdn.com/blogs.uoregon.edu/dist/6/3554/files/2013/06/light_odden_2017_post_print-wf76v3.pdf)

Abstract

The proliferation of cultural objects, such as music, books, film and websites, has created a new problem: How do consumers determine the value of cultural objects in an age of information glut? Crowd-sourcing – paralleling word-of-mouth recommendations – has taken center stage, yet expert opinion has alsoassumed renewed importance. Prior work on the valuation of artworks and other cultural artifacts identifies ways critics establish and maintain classificatory boundaries, such as genre. We extend this research by offering a theoretical approach emphasizing the dynamics of critics’ valuation and classification. Empirically, this analysis turns to Pitchfork.com, an influential music review website, to examine the relationship between classification and valuation. Using topic models of fourteen years of Pitchfork.com album reviews (n=14,495), we model the dynamics of valuation through genre and additional factors predictive of positive reviews and cultural consecration. We use gold record awards to study the relationship between valuation processes and commercial outcomes. Conclusions highlight the role of professional critics, alongside crowdsourcing and other forms of criticism, in the dynamic process of valuation and encourage the continued exploration of fruitful ways to connect computational and more canonical ways of conducting sociological research.

The data for this analysis are primarily from the Pitchfork.com music review website. 

Here is a brief description of the data files:

- data/pos_rr.txt is a file containing part-of-speech tagged unigrams for each review. 
- data/specmeta.Rda and data/spectheta.Rda contain data from the stm
- data/spectalk.Rda consists of data for evaluating the number of k in the stm
- data/lda25.Rda contains the stm
- data/tp25.Rda consists of the data used for the analysis and the creation of the main figures.

Here is a brief descripton of the of the scripts:

- stm_models.R consists of the code for making the stms
- reg_models_tbls_figs.R consists of the code for the relevant parts of the paper  