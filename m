From: David Miller <davem@davemloft.net>
Date: Thu, 07 Nov 2019 20:01:31 -0800 (PST)
Subject: [Intel-wired-lan] [PATCH net-next 0/2] net: Demote MTU change
 prints to debug
In-Reply-To: <20191107223537.23440-1-f.fainelli@gmail.com>
References: <20191107223537.23440-1-f.fainelli@gmail.com>
Message-ID: <20191107.200131.396855107998573876.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Florian Fainelli <f.fainelli@gmail.com>
Date: Thu,  7 Nov 2019 14:35:35 -0800

> This patch series demotes several drivers that printed MTU change and
> could therefore spam the kernel console if one has a test that it's all
> about testing the values. Intel drivers were not also particularly
> consistent in how they printed the same message, so now they are.

Series applied, thanks Florian.
