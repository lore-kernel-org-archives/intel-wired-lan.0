From: Benjamin LaHaise <bcrl@kvack.org>
Date: Mon, 11 Oct 2021 18:28:00 -0400
Subject: [Intel-wired-lan] i40e pppoe rss
Message-ID: <20211011222800.GA17234@kvack.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hello all,

I have been trying to get RSS working for incoming PPPoE packets with the
Linux i40e driver.  After loading the DDP .pkgo file for PPPoE using
"ethtool -f enp43s0f0 ppp-oe-ol2tpv2.pkgo 100", packets still come in on a
single queue.  Changing destination IP addresses or port numbers in UDP
packets does not result in any change in the ingress queue.  Are the
ethtool commands required to enable RSS with PPPoE documented anywhere?
The only documentation seems to rely on test-pmd with DPDK, but I am using
the native Linux drivers and XDP.

		-ben
-- 
"Thought is the essence of where you are now."
