From: Lino Sanfilippo <LinoSanfilippo@gmx.de>
Date: Fri, 01 May 2015 14:15:42 +0200
Subject: [Intel-wired-lan] [PATCH 2/3] r8169: Use dev_kfree_skb in Tx
	cleanup path
In-Reply-To: <55436C4B.7090509@gmx.de>
References: <20150430205423.1512.13487.stgit@ahduyck-vm-fedora22>
 <20150430205824.1512.35158.stgit@ahduyck-vm-fedora22>
 <20150501093420.GA11669@electric-eye.fr.zoreil.com> <55436C4B.7090509@gmx.de>
Message-ID: <55436E6E.5050609@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 01.05.2015 14:06, Lino Sanfilippo wrote:

> which did just the opposite: replace dev_kfree() with dev_kfree_any()
> for that reason. See
> 

Um, this should of course be dev_kfree_skb() and dev_kfree_skb_any().

Lino

