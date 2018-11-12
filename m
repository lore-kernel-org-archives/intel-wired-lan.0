From: Anshuman Khandual <anshuman.khandual@arm.com>
Date: Mon, 12 Nov 2018 09:40:39 +0530
Subject: [Intel-wired-lan] [RFC] mm: Replace all open encodings for
 NUMA_NO_NODE
In-Reply-To: <1e9393c5-ff43-8ec7-dd6c-a662f09ef7c1@gmail.com>
References: <1541990515-11670-1-git-send-email-anshuman.khandual@arm.com>
 <1e9393c5-ff43-8ec7-dd6c-a662f09ef7c1@gmail.com>
Message-ID: <b92e3275-7a04-a148-bb5b-38658c270583@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



On 11/12/2018 09:27 AM, Joseph Qi wrote:
> For ocfs2 part, node means host in the cluster, not NUMA node.
> 

Does not -1 indicate an invalid node which can never be present ?
