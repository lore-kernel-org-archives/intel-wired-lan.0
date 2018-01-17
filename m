From: sethsimon@sdf.org <sethsimon@sdf.org>
Date: Wed, 17 Jan 2018 23:45:47 -0000
Subject: [Intel-wired-lan] Missing device ids in e100.c?
Message-ID: <d1ee433614608c72175747c2767bf20a.squirrel@mx.sdf.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hi,
I think I found an oversight in e100.c: The DOS packet driver
based on the same chipset includes 3 additional PCI device ids
(1035, 1036, and 1037 (all ICH 3)) that aren't in e100.c. See
il.asm:207 in http://www.crynwr.com/drivers/e100b11b.zip.

- Seth Simon


