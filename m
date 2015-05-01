From: Lino Sanfilippo <LinoSanfilippo@gmx.de>
Date: Fri, 01 May 2015 14:06:35 +0200
Subject: [Intel-wired-lan] [PATCH 2/3] r8169: Use dev_kfree_skb in Tx
	cleanup path
In-Reply-To: <20150501093420.GA11669@electric-eye.fr.zoreil.com>
References: <20150430205423.1512.13487.stgit@ahduyck-vm-fedora22>
 <20150430205824.1512.35158.stgit@ahduyck-vm-fedora22>
 <20150501093420.GA11669@electric-eye.fr.zoreil.com>
Message-ID: <55436C4B.7090509@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 01.05.2015 11:34, Francois Romieu wrote:
> Alexander Duyck <alexander.h.duyck@redhat.com> :
>> This change replaces the use of either dev_kfree_skb_any or
>> dev_consume_skb_any in the Tx cleanup path of this driver with
>> dev_kfree_skb.  There isn't any need for the "_any" version of these
>> functions since the NAPI cleanup context is not a hard irq context.
> 
> netconsole ?
> 
> __dev_kfree_skb_any contains a big "if (... || irqs_disabled())" test
> and the NAPI poll handler is called with irq disabled from
> netpoll_send_skb_on_dev.
> 

Indeed. Also there have been changes from Eric Biederman not long ago,
which did just the opposite: replace dev_kfree() with dev_kfree_any()
for that reason. See

http://marc.info/?l=linux-stable-commits&m=142965098111361&w=2

[CCing Eric]

Regards,
Lino
