# ValidationCableMonitoring
a PCA-based cable anomaly detection solution developed using measurement data to validate the idea of cable health monitoring using power line communications signals.

Description of files:
New_Cable/CABLE1.S2P: S parameter measurement of 30-meter cable A as the device under test (DUT) \
New_Cable/CABLE2.S2P: S parameter measurement of 30-meter cable B as the DUT
Test5_Intact: S parameter measurement of PLC network under intact conditions (PLC network: VNA Port1 - Cable A - Power bar with loads- Cable B - VNA Port 2)
Test#a_D#b: S parameter measurement of PLC network under degraded conditions (D1-D7 corresponding to degradation stage 1-7 described in the paper)
TestXX/CASE#c.S2P: S parameter measurement (#c 2-9: non-energized measurement; #c 12-19:energized measurement)
synthetic_generation_Training.m: MATLAB script to generate channel samples for training
synthetic_generation_Test.m: MATLAB script to generate channel samples for testing
PCA_apply.m: MATLAB script to apply PCA (obtain training/testing error without anomaly detection)
PCA_threshold_new.m: MATLAB script to apply PCA for anomaly detection
PCA_clustering_NE.m: MATLAB script for clustering as pre-processing for non-energized condition
PCA_clustering_E.m: MATLAB script for clustering as pre-processing for energized condition
AD_single_load.m: MATLAB script for anomaly detection assuming the load condition is known

Description of cases: 
CASE2/CASE12: power bar unloaded
CASE3/CASE13: water kettle (K) only
CASE4/CASE14: computer monitor (M) only
CASE5/CASE15: K+M
CASE6/CASE16: electric fan (F) only
CASE7/CASE17: F+K
CASE8/CASE18: F+M
CASE9/CASE:19: F+M+K

==
PLC PCA-based Cable Anomaly Detector License==
==
Open Source License

Copyright (c) 2023 University of British Columbia.
All rights reserved.

Developed by:

   Yinjia Huo and Lutz Lampe

   University of British Columbia

   https://github.com/ubcyinjia/ValidationCableMonitoring
   
Permission is hereby granted, free of charge, to any person obtaining a copy of
this software and associated documentation files (the "Software"), to deal with
the Software without restriction, including without limitation the rights to
use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies
of the Software, and to permit persons to whom the Software is furnished to do
so, subject to the following conditions:

    * Redistributions of source code must retain the above copyright notice,
      this list of conditions and the following disclaimers.

    * Redistributions in binary form must reproduce the above copyright notice,
      this list of conditions and the following disclaimers in the
      documentation and/or other materials provided with the distribution.

    * Neither the name of the The University of British Columbia,
      nor the names of the contributors may be used to
      endorse or promote products derived from this Software without specific
      prior written permission.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL THE
CONTRIBUTORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS WITH THE
SOFTWARE.
