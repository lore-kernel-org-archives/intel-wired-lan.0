From: David Miller <davem@davemloft.net>
Date: Wed, 08 Jul 2020 16:09:25 -0700 (PDT)
Subject: [Intel-wired-lan] [PATCH net-next] bonding: don't need RTNL for
 ipsec helpers
In-Reply-To: <20200708225849.25198-1-jarod@redhat.com>
References: <20200708225849.25198-1-jarod@redhat.com>
Message-ID: <20200708.160925.601637997950999733.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Jarod Wilson <jarod@redhat.com>
Date: Wed,  8 Jul 2020 18:58:49 -0400

> The bond_ipsec_* helpers don't need RTNL, and can potentially get called
> without it being held, so switch from rtnl_dereference() to
> rcu_dereference() to access bond struct data.
> 
> Lightly tested with xfrm bonding, no problems found, should address the
> syzkaller bug referenced below.
> 
> Reported-by: syzbot+582c98032903dcc04816 at syzkaller.appspotmail.com
> Signed-off-by: Jarod Wilson <jarod@redhat.com>

Applied, thank you.
