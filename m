From: David Ahern <dsa@cumulusnetworks.com>
Date: Thu, 13 Oct 2016 08:32:40 -0600
Subject: [Intel-wired-lan] [PATCH net-next 00/11] net: Fix netdev
	adjacency tracking
In-Reply-To: <20161013073424.GB1816@nanopsycho.orion>
References: <1476305519-28833-1-git-send-email-dsa@cumulusnetworks.com>
 <20161013073424.GB1816@nanopsycho.orion>
Message-ID: <eedea44e-24de-e6f7-c42f-a13461d16d6a@cumulusnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 10/13/16 1:34 AM, Jiri Pirko wrote:
> 
> Although I didn't like the "all-list" idea when Veaceslav pushed it
> because it looked to me like a big hammer, it turned out to be very handy
> and quick for traversing neighbours. Why it cannot be fixed?
> 
> The walks with possibly hundreds of function calls instead of a single
> list traverse worries me.
> 

I have been looking at this code for a week now. Every solution I came up with that solved the original problems introduced new ones -- usually with adjacency remove expecting an adjacency that did not exist. In the end I came to the conclusion it is not possible to maintain an all_adj_list when the upper tree can have multiple paths to the top device. If someone thinks otherwise I am happy to test a patch.
