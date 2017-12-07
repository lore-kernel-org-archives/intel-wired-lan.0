From: Shannon Nelson <shannon.nelson@oracle.com>
Date: Thu, 7 Dec 2017 14:19:54 -0800
Subject: [Intel-wired-lan] [next-queue 06/10] ixgbe: restore offloaded
 SAs after a reset
In-Reply-To: <CAKgT0UfDnHnPCM8Px-TCbiB4wBQGN9CskftyF+4V=5g2F72QVw@mail.gmail.com>
References: <1512452116-14795-1-git-send-email-shannon.nelson@oracle.com>
 <1512452116-14795-7-git-send-email-shannon.nelson@oracle.com>
 <CAKgT0UdOG5H02Tqin4OhEvp=6ZDn365g04JvVOVAiTyCnncPew@mail.gmail.com>
 <90efb41d-2cab-f623-8b3d-318f3ad6e135@oracle.com>
 <CAKgT0UfDFyH8qjg_-cdGYx5f06iTwydcMTcZ5FvhKJ+=2bNTLQ@mail.gmail.com>
 <f8f1d753-3f29-6aa7-326c-423f38036877@oracle.com>
 <CAKgT0UfDnHnPCM8Px-TCbiB4wBQGN9CskftyF+4V=5g2F72QVw@mail.gmail.com>
Message-ID: <c4bc6aea-7838-fc9b-1588-8126d0cb1377@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 12/7/2017 1:52 PM, Alexander Duyck wrote:
> 
> The reads/writes themselves should be cheap. These kind of things only
> get to be really expensive when you start looking at adding delays in
> between the writes/reads polling on things. As long as we aren't
> waiting milliseconds on things you can write/read thousands of
> registers and not even notice it.
> 
> One thing you might look at doing in order to speed some of this up a
> bit would be to also combine updating the Tx SA and Rx SA in your
> clear_hw_tables loop so that you could do them in parallel in your
> loop instead of having to do them in series. Anyway it is just a
> thought. If nothing else you might look at timing the function to see
> how long it actually takes. I suspect it shouldn't be too long since
> the turnaround time on the PCIe bus should be in microseconds so odds
> are reading/writing 35K registers might ovinly add a few milliseconds
> to total reset time.
> 

Good ideas - thanks,
sln
