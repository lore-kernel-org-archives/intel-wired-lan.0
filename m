From: Francois Romieu <romieu@fr.zoreil.com>
Date: Fri, 29 Jul 2016 01:28:44 +0200
Subject: [Intel-wired-lan] [e1000_netpoll] BUG: sleeping function called
 from invalid context at kernel/irq/manage.c:110
In-Reply-To: <1469684635.9389.4.camel@edumazet-glaptop3.roam.corp.google.com>
References: <20160726035003.GA15095@wfg-t540p.sh.intel.com>
 <1469524492.17736.3.camel@edumazet-glaptop3.roam.corp.google.com>
 <1469655487.2232.49.camel@intel.com>
 <1469684635.9389.4.camel@edumazet-glaptop3.roam.corp.google.com>
Message-ID: <20160728232844.GA25372@electric-eye.fr.zoreil.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Eric Dumazet <eric.dumazet@gmail.com> :
[...]
> I would prefer having a definitive advice from Thomas Gleixner and/or
> others if disable_irq() is forbidden from IRQ path.
> 
> As I said, about all netpoll() methods in net drivers use disable_irq()
> so a lot of patches would be needed.

s/about all/many/

There has been a WARN_ONCE(!irqs_disabled() in netpoll_send_skb_on_dev for
quite some time now but it's apparently screened by too many tests to be
effective. :o/

-- 
Ueimor
