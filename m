From: =?unknown-8bit?q?Bj=C3=B6rn_T=C3=B6pel?= <bjorn.topel@intel.com>
Date: Fri, 5 Oct 2018 06:59:52 +0200
Subject: [Intel-wired-lan] [PATCH v2 0/5] Introducing ixgbe AF_XDP ZC
 support
In-Reply-To: <20181004231848.33efd81f@redhat.com>
References: <20181002080034.11754-1-bjorn.topel@gmail.com>
 <20181004231848.33efd81f@redhat.com>
Message-ID: <5a801d72-6dcd-a8e4-f1a6-c8f3cc1e560e@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 2018-10-04 23:18, Jesper Dangaard Brouer wrote:
> I see similar performance numbers, but my system can crash with 'txonly'.

Thanks for finding this, Jesper!

Can you give me your "lspci -vvv" dump of your NIC, so I know what ixgbe
flavor you've got?

I'll dig into it right away.


Bj?rn
