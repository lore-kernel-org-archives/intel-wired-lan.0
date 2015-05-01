From: Francois Romieu <romieu@fr.zoreil.com>
Date: Fri, 1 May 2015 11:34:20 +0200
Subject: [Intel-wired-lan] [PATCH 2/3] r8169: Use dev_kfree_skb in Tx
	cleanup path
In-Reply-To: <20150430205824.1512.35158.stgit@ahduyck-vm-fedora22>
References: <20150430205423.1512.13487.stgit@ahduyck-vm-fedora22>
 <20150430205824.1512.35158.stgit@ahduyck-vm-fedora22>
Message-ID: <20150501093420.GA11669@electric-eye.fr.zoreil.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Alexander Duyck <alexander.h.duyck@redhat.com> :
> This change replaces the use of either dev_kfree_skb_any or
> dev_consume_skb_any in the Tx cleanup path of this driver with
> dev_kfree_skb.  There isn't any need for the "_any" version of these
> functions since the NAPI cleanup context is not a hard irq context.

netconsole ?

__dev_kfree_skb_any contains a big "if (... || irqs_disabled())" test
and the NAPI poll handler is called with irq disabled from
netpoll_send_skb_on_dev.

-- 
Ueimor
