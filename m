From: Sowmini Varadhan <sowmini.varadhan@oracle.com>
Date: Wed, 30 Mar 2016 16:40:23 -0400
Subject: [Intel-wired-lan] [net PATCH] i40e/i40evf: Limit TSO to 7
 descriptors for payload instead of 8 per packet
In-Reply-To: <1459368904.6473.207.camel@edumazet-glaptop3.roam.corp.google.com>
References: <20160330064213.12927.46852.stgit@localhost.localdomain>
 <20160330170011.GB27540@oracle.com>
 <CAKgT0UdTgaeamyLetGPK0mqMNS-80BTc8t-WdSGJuuLDfz4JOg@mail.gmail.com>
 <20160330172001.GD27540@oracle.com>
 <CAKgT0Ufb-_X-DD2jYkVJQwLZ-JBfWD2Biuhi6YaxWBeNy9K2fQ@mail.gmail.com>
 <20160330124135.000054c6@unknown>
 <20160330200959.GI27540@oracle.com>
 <1459368904.6473.207.camel@edumazet-glaptop3.roam.corp.google.com>
Message-ID: <20160330204023.GK27540@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On (03/30/16 13:15), Eric Dumazet wrote:
> You might try netperf -t TCP_SENDFILE -- -m 150
> 
> to let netperf use sendfile() on small frags.

that still did not reproduce it but let me try beating on
that approach with more permutations.

BTW, another data-point that may help debug this: even with i40e,
if you use the "-o" option to the rds-stress invocation, there are
no problems: the "-o" option  enforces uni-directional data
transfer, so one side is pure-Tx, other side is pure-Rx. 

It is only when both sides simultaneously do both Tx and Rx
on the tcp socket that you see the issue. I dont know if
that provides any clues.

--Sowmini

