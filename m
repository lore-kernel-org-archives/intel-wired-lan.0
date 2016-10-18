From: David Ahern <dsa@cumulusnetworks.com>
Date: Tue, 18 Oct 2016 09:58:23 -0600
Subject: [Intel-wired-lan] [PATCH v3 net-next 00/11] net: Fix netdev
	adjacency tracking
In-Reply-To: <20161018.114631.1954199143257806104.davem@davemloft.net>
References: <1476756953-30923-1-git-send-email-dsa@cumulusnetworks.com>
 <20161018.114631.1954199143257806104.davem@davemloft.net>
Message-ID: <295372c1-a359-d560-2856-45e5f0c183be@cumulusnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 10/18/16 9:46 AM, David Miller wrote:
> Series applied, but the recursion is disappointing.
> 
> If we run into problems due to kernel stack depth because of this with
> some configurations (reasonable or not, if we allow it then it can't
> crash the kernel), we will either need to find a way to make this walk
> iterative or revert these changes.

understood.

Since 4.9 is tagged as the next LTS I would like to see the series applied to it at some point - assuming no problems show up with wider exposure in net-next.
