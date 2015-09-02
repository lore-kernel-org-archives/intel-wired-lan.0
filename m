From: Hisashi T Fujinaka <htodd@twofifty.com>
Date: Tue, 1 Sep 2015 22:44:15 -0700 (PDT)
Subject: [Intel-wired-lan] [PATCH] ixgbe: Limit lowest interrupt rate
 for adaptive interrupt moderation to 12K
In-Reply-To: <55E655A3.9010304@gmail.com>
References: <20150730221927.984.91700.stgit@ahduyck-vm-fedora22>
 <55E655A3.9010304@gmail.com>
Message-ID: <alpine.NEB.2.11.1509012243190.1164@chris.i8u.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Tue, 1 Sep 2015, Alexander Duyck wrote:

> On 07/30/2015 03:19 PM, Alexander Duyck wrote:
>> This patch updates the lowest limit for adaptive interrupt interrupt
>> moderation to roughly 12K interrupts per second.
...
> Has there been any update on this patch?  I submitted it just over a month 
> ago now and it hasn't received any feedback.  I was hoping this could be 
> submitted before the merge window closes for net-next.
>
> Thanks.

I'm nobody, but it makes sense to me.

-- 
Hisashi T Fujinaka - htodd at twofifty.com (also todd.fujinaka at intel.com)
BSEE + BSChem + BAEnglish + MSCS + $2.50 = coffee
