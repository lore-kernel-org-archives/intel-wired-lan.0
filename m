From: David Miller <davem@davemloft.net>
Date: Wed, 08 Jul 2015 16:15:33 -0700 (PDT)
Subject: [Intel-wired-lan] [PATCH 0/3] rtnl_lock fixes
In-Reply-To: <559BF5F8.2000500@virtuozzo.com>
References: <559BF5F8.2000500@virtuozzo.com>
Message-ID: <20150708.161533.531768243562810631.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Vasily Averin <vvs@virtuozzo.com>
Date: Tue, 07 Jul 2015 18:53:28 +0300

> While investigation possible reasons of net_todo_list corruption 
> on rhel6 based OpenVZ kernel I've found few places not fixed in mainline.

I'm assuming the Intel folks will pick these up.
