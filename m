From: Hillf Danton <hdanton@sina.com>
Date: Fri, 12 Jul 2019 00:00:25 +0800
Subject: [Intel-wired-lan] bpf_prog_free_deferred bug. WAS: Re: WARNING in
 mark_chain_precision
Message-ID: <20190711160025.8796-1-hdanton@sina.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>


On Thu, 11 Jul 2019 07:29:42 +0800 Andrii Nakryiko wrote:
>
> I'm curious what makes BPF_PROG_TYPE_SOCKET_FILTER (and

Me too. And thanks to folks casting light on it.

> BPF_PROG_TYPE_SK_REUSEPORT) special, compared to all the other types
> of BPF programs. If it's something to do with sockets specifically,
> there are a bunch of other programs that deal with sockets, so should
> they be handled specially as well (e.g., BPF_PROG_TYPE_CGROUP_SOCK)?
>
> Daniel, do you have any insight here?

