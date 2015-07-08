From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Date: Wed, 08 Jul 2015 16:23:43 -0700
Subject: [Intel-wired-lan] [PATCH 0/3] rtnl_lock fixes
In-Reply-To: <20150708.161533.531768243562810631.davem@davemloft.net>
References: <559BF5F8.2000500@virtuozzo.com>
 <20150708.161533.531768243562810631.davem@davemloft.net>
Message-ID: <1436397823.3214.15.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Wed, 2015-07-08 at 16:15 -0700, David Miller wrote:
> From: Vasily Averin <vvs@virtuozzo.com>
> Date: Tue, 07 Jul 2015 18:53:28 +0300
> 
> > While investigation possible reasons of net_todo_list corruption 
> > on rhel6 based OpenVZ kernel I've found few places not fixed in
> mainline.
> 
> I'm assuming the Intel folks will pick these up

Correct, got them queued up.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: This is a digitally signed message part
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20150708/a7a1a0a3/attachment.asc>
