From: David Miller <davem@davemloft.net>
Date: Fri, 01 May 2015 11:36:59 -0400 (EDT)
Subject: [Intel-wired-lan] [PATCH 2/3] r8169: Use dev_kfree_skb in Tx
	cleanup path
In-Reply-To: <55436E6E.5050609@gmx.de>
References: <20150501093420.GA11669@electric-eye.fr.zoreil.com>
 <55436C4B.7090509@gmx.de> <55436E6E.5050609@gmx.de>
Message-ID: <20150501.113659.1615816780747363615.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Lino Sanfilippo <LinoSanfilippo@gmx.de>
Date: Fri, 01 May 2015 14:15:42 +0200

> On 01.05.2015 14:06, Lino Sanfilippo wrote:
> 
>> which did just the opposite: replace dev_kfree() with dev_kfree_any()
>> for that reason. See
>> 
> 
> Um, this should of course be dev_kfree_skb() and dev_kfree_skb_any().

Indeed.

Alex, you can't make this change.  netconsole transmits can occur
from any context whatsoever.

