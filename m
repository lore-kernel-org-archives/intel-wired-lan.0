From: Benjamin LaHaise <bcrl@kvack.org>
Date: Thu, 13 Aug 2015 14:56:07 -0400
Subject: [Intel-wired-lan] ixgbe on Xeon D-1540 does not come up at 1
	gigabit or 100Mbps speeds
Message-ID: <20150813185607.GL24295@kvack.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hello,

I have just tried to set up a new Xeon D-1540 system (a Supermicro 
X10SDV-8C-TLN4F), and it appears that the ixgbe driver in Linus' tree 
as of commit 58ccab91342c1cc1fe08da9b198ac5d763706c2e is unable to 
negotiate link up at either gigabit or 100Mbps speeds.  If I plug the 
10Gbase-T into each other back to back, the ports are able to come up 
and transfer data.  Please let me know if any further information is 
required to reproduce this bug.

		-ben
-- 
"Thought is the essence of where you are now."
