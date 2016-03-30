From: Sowmini Varadhan <sowmini.varadhan@oracle.com>
Date: Wed, 30 Mar 2016 13:00:11 -0400
Subject: [Intel-wired-lan] [net PATCH] i40e/i40evf: Limit TSO to 7
 descriptors for payload instead of 8 per packet
In-Reply-To: <20160330064213.12927.46852.stgit@localhost.localdomain>
References: <20160330064213.12927.46852.stgit@localhost.localdomain>
Message-ID: <20160330170011.GB27540@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On (03/29/16 23:44), Alexander Duyck wrote:
> This patch has been sanity checked only.  I cannot yet guarantee it
> resolves the original issue that was reported.  I'll try to get a
> reproduction environment setup tomorrow but I don't know how long that
> should take.

I tried this out with rds-stress on my test-pair, unfortunately, I
still see the Tx hang.

Setting up the test is quite easy- for reference, the instructions 
are here:
   https://sourceforge.net/p/e1000/mailman/message/34936766/

--Sowmini
