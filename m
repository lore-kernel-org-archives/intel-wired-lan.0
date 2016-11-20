From: David Miller <davem@davemloft.net>
Date: Sat, 19 Nov 2016 21:47:40 -0500 (EST)
Subject: [Intel-wired-lan] [PATCH] i40e: remove unnecessary __packed
In-Reply-To: <1479592438-17078-1-git-send-email-tushar.n.dave@oracle.com>
References: <1479592438-17078-1-git-send-email-tushar.n.dave@oracle.com>
Message-ID: <20161119.214740.728792132654733676.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Tushar Dave <tushar.n.dave@oracle.com>
Date: Sat, 19 Nov 2016 13:53:58 -0800

> 'struct i40e_dma_mem' defined with 'packed' directive causing kernel
> unaligned errors on sparc.

I really wish people would get out of the habit of just slapping
the __packed attribute onto structures seemingly by default.
