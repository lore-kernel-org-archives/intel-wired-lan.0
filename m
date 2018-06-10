From: Masanari Iida <standby24x7@gmail.com>
Date: Sun, 10 Jun 2018 23:37:48 +0900
Subject: [Intel-wired-lan] [BUG] make htmldocs failed with error after add
 converted RST file.
Message-ID: <CALLJCT2K9Tkj1d-xq6-zmNhOwLjQiStnMaE7PJCTDDT+Pi=L1w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

After merger a patch,  make htmldocs  and make xmldocs
failed with error.

reST markup error:
/home/iida/Repo/linux-2.6/Documentation/networking/e100.rst:90:
(SEVERE/4) Unexpected section title.

Configuring the Driver on Different Distributions
-------------------------------------------------
Documentation/Makefile:68: recipe for target 'htmldocs' failed
make[1]: *** [htmldocs] Error 1
Makefile:1542: recipe for target 'htmldocs' failed
make: *** [htmldocs] Error 2


85d63445f41125dafeddda74e5b13b7eefac9407 is the first bad commit
commit 85d63445f41125dafeddda74e5b13b7eefac9407
Author: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Date:   Thu May 10 12:20:13 2018 -0700

    Documentation: e100: Update the Intel 10/100 driver doc


Reported-by: Masanari Iida <standby24x7@gmail.com>

Masanari Iida
