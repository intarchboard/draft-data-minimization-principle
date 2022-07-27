---
title: "Data minimization"
abbrev: Data Minimization in Internet Architecture
docname: draft-arkko-iab-data-minimization-principle
date: July 2022
category: info

ipr: trust200902
keyword: Internet-Draft

stand_alone: yes
pi: [toc, sortrefs, symrefs]

author:
  -
    ins: J. Arkko
    name: Jari Arkko
    org: Ericsson
    street: Valitie 1B
    city: Kauniainen
    country: Finland
    email: jari.arkko@piuha.net

normative:


informative:
  RFC3552: 
  RFC7258: 
  RFC7858:
  RFC8546:
  RFC8484:
  RFC8558:
  RFC8980:
  RFC9000: 
  I-D.farrell-etm:
  I-D.arkko-arch-internet-threat-model-guidance:
  I-D.lazanski-smart-users-internet:
  I-D.iab-path-signals-collaboration:
  I-D.thomson-tmi:
  I-D.iab-use-it-or-lose-it:
  I-D.wood-pearg-website-fingerprinting:
  I-D.ietf-ohai-ohttp:
  I-D.pauly-dprive-oblivious-doh:
  I-D.ietf-ppm-dap:
  I-D.annee-dprive-oblivious-dns:
  Confidentiality:
   title: "IAB Statement on Internet Confidentiality"
   date: November 2014
   author:
     - ins: The Internet Architecture Board
   seriesinfo: "https://www.iab.org/2014/11/14/iab-statement-on-internet-confidentiality/"
  PoLP:
   title: "The Protection of Information in Computer Systems"
   date: October 1975
   author:
     - ins: J. Saltzer
     - ins: M. Schroader
   seriesinfo: "Fourth ACM Symposium on Operating System Principles"
  WP2021:
   title: "There’s no escape from Facebook, even if you don’t use it"
   date: August 2021
   author:
     - ins: Geoffrey A. Fowler
   seriesinfo: "Washington Post"
  Fingerprinting:
    title: "Browser Fingerprinting: A survey"
    date: November 2019
    author:
     - ins: P. Laperdrix
     - ins: N. Bielova
     - ins: B. Baudry
     - ins: G. Avoine
    seriesinfo: "arXiv:1905.01051v2 [cs.CR] 4 Nov 2019"
  AmIUnique:
    title: "Am I Unique?"
    date: 2020
    author:
    - ins: INRIA
    seriesinfo: "https://amiunique.org"
  
--- abstract

Communications security has been at the center of many security
improvements in the Internet. The goal has been to ensure that
communications are protected against outside observers and
attackers. This document recommends that this is no longer alone sufficient
to cater for the security and privacy issues seen on the Internet
today. For instance, it is often also necessary to protect against
endpoints that are compromised, malicious, or whose interests simply
do not align with the interests of users. While such protection is
difficult, there are some measures that can be taken. It is important
to consider the role of data passed to various parties -- including
the primary protocol participants -- and balance the information given
to them considering their roles and possible compromise of the
information.

--- middle

# Introduction {#introduction}

Communications security has been at the center of many security
improvements on the Internet. The goal has been to ensure that
communications are protected against outside observers and
attackers.

This has been exemplified in many aspects of IETF efforts, in the
threat models {{RFC3552}}, concerns about surveillance {{RFC7258}},
IAB statements {{Confidentiality}}, and the introduction of encryption
in many protocols {{RFC9000}}, {{RFC7858}}, {{RFC8484}}. This has been
very successful. Advances in protecting most of our communications
with strong cryptographic has resulted in much improved security. Work on
these advances continues to be a key part of IETF's security effort.

This document recommends that further action is needed, however. For
instance, the possibility that endpoints are compromised, malicious,
or have interests that do not align with the interests of users. Given
the advances in communication seceurity, adversaries have had to
increase their pressure against new avenues of attack. New adversaries
and risks have also arisen, e.g., due to increasing amount of
information stored in various Internet services.

While such protection is difficult, there are some measures that can
be taken. This document focuses on the specific question of data
passed to various parties -- including the primary protocol
participants. What information is given to any other party should
depend on the role of that party. And the possibility of a compromised
entity sharing the information beyond the users' expectations should be
kept in mind.

Careful control of information is also useful for technology
evolution. For instance, allowing a party to unnecessarily collect or
receive information may lead to a similar effect as described in
{{RFC8546}} for protocols: regardless of initial expectations, over
time unnecessary information will get used, leading to, for instance,
ossification.  Systems end up depend on having access to exactly the
same information as they had access to previously. This makes it hard
to change what information is provided or how it is provided.

# Recommendations {#rec}

The Principle of Least Privilege {{PoLP}} is applicable:

    "Every program and every user of the system should operate 
     using the least set of privileges necessary to complete the
     job."

In this context, it is recommended that the protocol participants
minimize the information they share. I.e., they should provide only
the information to each other that is necessary for the function that
is expected to be performed by the other party.

This recommendation is of course very similar to the current approach
to communications security. As with communication security, we try to
avoid providing too much information as it may be misused or leak
through attacks. The same principle applies not just to routers and
potential attackers on path, but also many other services in the
Internet, including servers that provide some function.

Of course, participants may provide more information to each after
careful consideration, e.g., information provided in exchange of
some benefit, or to parties that are trusted by the participant.

# Discussion {#disc}

Information sharing may relate to different types of protocol exchanges:

* The interaction of an endpoint with the network, e.g., information
  they provide in any network attachment process or the wire images of
  the packets sent via the network.

* The interaction of an endpoint with intermediaries such as group
  messaging servers or NAT traversal relays.

* The interaction of an endpoint with a service, such as a website,
  social networking function, or a telemetry collection point.

* End-to-end interactions between users, represented by applications
  running on their computers.

Information sharing need not be explicitly carried information, e.g., a
data item in a message sent to a protocol participant. Indirectly
inferred information can also end up being shared, such as message arrival times or
patterns in the traffic flow. Information may also be obtained from
fingerprinting the protocol participants, in an effort to identify
unique endpoints or users.

Information may also be combined from multiple sources, e.g., websites
and social media systems collaborating to identify visiting users
{{WP2021}}.

## Dealing with compromise

Even with careful exposure of information, compromises may occur.  It
is important to build defenses to protect information, even when some
component in a system becomes compromised. This may involve designs
where no single party has all information such as with Oblivious DNS
{{I-D.annee-dprive-oblivious-dns}}, {{I-D.pauly-dprive-oblivious-doh}}
or HTTP {{I-D.ietf-ohai-ohttp}}, cryptographic designs where a service
such as with the recent IETF PPM effort {{I-D.ietf-ppm-dap}}, service
side encryption of data at rest, confidential computing, and other
mechanisms.

Protocols can ensure that forward secrecy is provided, so
that the damage resulting from a compromise of keying material has
limited impact.

On the client side, the client may trust that another party handles
information appropriately, but take steps to ensure or verify that
this is the case. For instance, as discussed above, the
client can encrypt a message only to the actual final recipient, even
if the server holds the message before it is delivered. 

A corollary of the recommendation is that information should not be
disclosed, stored, or routed in cleartext through services that do not
need to have that information for the function they
perform.

For instance, a transport connection between two components of a
system is not an end-to-end connection even if it encompasses all the
protocol layers up to the application layer. It is not end-to-end, if
the information or control function it carries extends beyond
those components. For instance, just because an e-mail server can read
the contents of an e-mail message do not make it a legitimate
recipient of the e-mail.

The general topic of ensuring that protocol mechanisms stays evolvable
and workable is covered in {{I-D.iab-use-it-or-lose-it}}. But the
associated methods for reducing fingerprinting possibilities probably
deserve further study {{Fingerprinting}} {{AmIUnique}}. {{I-D.wood-pearg-website-fingerprinting}} discusses
one aspect of this.

## Related work {#related}

Hardie {{RFC8558}} discusses path signals, i.e., messages to or from
on-path elements to endpoints. In the past, path signals were often
implicit, e.g., network nodes interpreting in a particular way
transport protocol headers originally intended for end-to-end
consumption.  The document recommends a principle that implicit
signals should be avoided and that explicit signals be used instead,
and only when the signal's originator intends that it be used by the
network elements on the path.

Arkko, Kuhlewind, Pauly, and Hardie
{{I-D.iab-path-signals-collaboration}} discuss the same topic, and
extend the RFC 8558 principles with recommendations to ensure minimum
set of parties, minimum information, and consent.

Thomson {{I-D.thomson-tmi}} discusses the role intermediaries in the
Internet architecture, at different layers of the stack. For instance,
a router is an intermediary, some parts of DNS infrastructure can be
intermediaries, messaging gateways are intermediaries. Thomson
discusses when intermediaries are or are not an appropriate tool, and
presents a number of principles relating to the use of intermediaries,
e.g., deliberate selection of protocol participants or limiting the
capabilities or information exposure related to the intermediaries.

Trammel and Kühlewind {{RFC8546}} discuss the concept of a "wire
image" of a protocol.  This is an abstraction of the information
available to an on-path non-participant in a networking protocol. It
relates to the topic of non-participants interpreting information that
is available to them in the "wire image" (or associated timing and
other indirect information). The issues are largely the same even for
participants. Even proper protocol participants may start to use
information available to them, regardless of whether it was intended
to that participant or simply relayed through them.
   

# Acknowledgements {#ack}

The author would like to thank the members of the IAB, and the
participants of IETF SAAG WG, Model-T IAB program, and the 2019 IAB
DEDR workshop that all discussed some aspects of these issues. The
author would like to acknowledge the significant
contributions of Martin Thomson, Stephen Farrell, Mark McFadden, John
Mattsson, Chris
Wood, Dominique Lazanski, Eric Rescorla, Russ Housley, Robin Wilton,
Mirja Kuehlewind, Tommy Pauly, Jaime Jiménez and Christian Huitema in
discussions around this general problem area.

This work has been influenced greatly by discussions about trends in
attacks, for instance, in {{RFC8980}}, {{I-D.farrell-etm}}
{{I-D.arkko-arch-internet-threat-model-guidance}},
{{I-D.lazanski-smart-users-internet}}, and others.
