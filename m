From: JD <jdtxs00@gmail.com>
Date: Thu, 17 Oct 2019 13:06:20 -0500
Subject: [Intel-wired-lan] VF/SRIOV question
Message-ID: <CAMnf+Phw525rfCHVDXz1uWZw4Y=HuyBjnhpqYzjx2dmgpsHMsA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hello,

I couldn't find anything in the spec/doc for the Intel 82599 series
NIC's regarding performance penalties with a higher number of VF's.

Currently I'm using 16 VF's with SR-IOV/QEMU, but the 82599 NIC
supports up to 63 VF's. From a driver/NIC perspective, are there any
performance considerations or penalties of enabling/using all of the
available VF's on a NIC?

If there isn't, is this the same case for other models (besides 82599) as well?

Thank you!
