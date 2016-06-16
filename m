From: Hannes Frederic Sowa <hannes@stressinduktion.org>
Date: Fri, 17 Jun 2016 01:01:38 +0200
Subject: [Intel-wired-lan] [net-next PATCH v3 17/17] vxlan: Add new UDP
 encapsulation offload type for VXLAN-GPE
In-Reply-To: <20160616192318.20872.40266.stgit@localhost.localdomain>
References: <20160616191851.20872.67154.stgit@localhost.localdomain>
 <20160616192318.20872.40266.stgit@localhost.localdomain>
Message-ID: <cd97e62f-9513-99c6-3f47-d849b268ef17@stressinduktion.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 16.06.2016 21:23, Alexander Duyck wrote:
> The fact is VXLAN with Generic Protocol Extensions cannot be supported by
> the same hardware parsers that support VXLAN.  The protocol extensions
> allow for things like a Next Protocol field which in turn allows for things
> other than Ethernet to be passed over the tunnel.  Most existing parsers
> will not know how to interpret this.
> 
> To resolve this I am giving VXLAN-GPE its own UDP encapsulation offload
> type.  This way hardware that does support GPE can simply add this type to
> the switch statement for VXLAN, and if they don't support it then this will
> fix any issues where headers might be interpreted incorrectly.
> 
> Signed-off-by: Alexander Duyck <aduyck@mirantis.com>

Acked-by: Hannes Frederic Sowa <hannes@stressinduktion.org>


