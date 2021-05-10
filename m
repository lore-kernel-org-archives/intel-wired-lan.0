From: Edward Cree <ecree.xilinx@gmail.com>
Date: Mon, 10 May 2021 14:58:59 +0100
Subject: [Intel-wired-lan] [PATCH 00/53] Get rid of UTF-8 chars that can
 be mapped as ASCII
In-Reply-To: <20210510153807.4405695e@coco.lan>
References: <cover.1620641727.git.mchehab+huawei@kernel.org>
 <2ae366fdff4bd5910a2270823e8da70521c859af.camel@infradead.org>
 <20210510135518.305cc03d@coco.lan>
 <df6b4567-030c-a480-c5a6-fe579830e8c0@gmail.com>
 <20210510153807.4405695e@coco.lan>
Message-ID: <b3366f65-35e1-8f1a-d8d8-ebd444c9499d@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 10/05/2021 14:38, Mauro Carvalho Chehab wrote:
> Em Mon, 10 May 2021 14:16:16 +0100
> Edward Cree <ecree.xilinx@gmail.com> escreveu:
>> But what kinds of things with ? or ? in are going to be grept for?
> 
> Actually, on almost all places, those aren't used inside math formulae, but
> instead, they describe video some resolutions:
Ehh, those are also proper uses of ?.  It's still a multiplication,
 after all.

> it is a way more likely that, if someone wants to grep, they would be 
> doing something like this, in order to get video resolutions:
Why would someone be grepping for "all video resolutions mentioned in
 the documentation"?  That seems contrived to me.

-ed
